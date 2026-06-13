# frozen_string_literal: true

require 'open3'

module Packager
  # A step executed by `sh -c`
  # Optionally can be elevated with sudo.
  class ShellStep
    SUDO_PREFIX = "sudo -S -p '' "

    attr_reader :label_suffix

    def initialize(command:, sudo_require: false, label_suffix: nil)
      @command = command
      @sudo_require = sudo_require
      @label_suffix = label_suffix
    end

    def execute(context)
      # Instead of an exception we get exit 127 on a missing program.
      stdin, stdout, stderr, wait_thr = Open3.popen3('sh', '-c', make_command)

      feed_password(stdin, context.pass) if @sudo_require
      stdin.close

      out = Thread.new { stdout.read }
      err = Thread.new { stderr.read }

      Result.new(out: out.value, err: err.value, ok: wait_thr.value.exitstatus&.zero?)
    rescue SystemCallError => e
      # Prevent one broken step from aborting the whole run.
      Result.new(out: '', err: e.message, ok: false)
    end

    private

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
