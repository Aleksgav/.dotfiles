# frozen_string_literal: true

require 'open3'

module Packager
  # A step executed by `sh -c`
  # Optionally can be elevated with sudo.
  class ShellStep
    SUDO_PREFIX = "sudo -S -p '' "
    CHUNK = 4096

    attr_reader :label_suffix

    def initialize(command:, sudo_require: false, label_suffix: nil)
      @command = command
      @sudo_require = sudo_require
      @label_suffix = label_suffix
    end

    # Streams stdout/stderr to the optional `on_line` block as it arrives (so a
    # live viewport can render it) while still accumulating the full output into
    # the returned Result for the failure dump. Segments split on "\n" (committed
    # lines) and bare "\r" (progress frames, redrawn in place).
    def execute(context, &on_line)
      # Instead of an exception we get exit 127 on a missing program.
      stdin, stdout, stderr, wait_thr = Open3.popen3('sh', '-c', make_command)

      feed_password(stdin, context.pass) if @sudo_require
      stdin.close

      out = +''
      err = +''
      out_thr = Thread.new { pump(stdout, out, false, on_line) }
      err_thr = Thread.new { pump(stderr, err, true, on_line) }
      out_thr.join
      err_thr.join

      Result.new(out: out, err: err, ok: wait_thr.value.exitstatus&.zero?)
    rescue SystemCallError => e
      # Prevent one broken step from aborting the whole run.
      Result.new(out: '', err: e.message, ok: false)
    end

    private

    # Reads `io` in chunks, mirroring the raw bytes verbatim into `sink` (for the
    # failure dump) while splitting a copy into segments for the live viewport.
    def pump(io, sink, err, on_line)
      buf = +''
      loop do
        chunk = io.readpartial(CHUNK)
        sink << chunk
        buf << chunk
        buf = emit_segments(buf, err, on_line)
      end
    rescue EOFError
      on_line&.call(buf, err, false) if on_line && !buf.empty?
    end

    # Emits complete segments from `buf`, returning the unterminated remainder.
    # "\n"/"\r\n" => committed line (progress=false); bare "\r" => progress frame.
    def emit_segments(buf, err, on_line)
      while (idx = buf.index(/[\r\n]/))
        if buf[idx] == "\n"
          on_line&.call(buf[0, idx], err, false)
          buf = buf[(idx + 1)..]
        elsif idx == buf.length - 1
          break # trailing "\r": wait for the next chunk to tell CR from CRLF
        elsif buf[idx + 1] == "\n"
          on_line&.call(buf[0, idx], err, false) # CRLF
          buf = buf[(idx + 2)..]
        else
          on_line&.call(buf[0, idx], err, true) # bare CR
          buf = buf[(idx + 1)..]
        end
      end
      buf
    end

    def make_command
      @sudo_require ? SUDO_PREFIX + @command : @command
    end

    def feed_password(stdin, pass)
      stdin.sync = true # broken pipe surface fast fail
      stdin.puts(pass)
    rescue Errno::EPIPE
      # cached sudo creds
    end
  end
end
