# frozen_string_literal: true

require 'tty/screen'

module Packager
  class Viewport
    HEIGHT_DIVISOR = 3 # live pane spans ~1/3 of the terminal height
    MIN_HEIGHT = 5 # ...but stay readable on short terminals
    MIN_TOP_ROWS = 3 # keep at least this many scrolling rows above the pane
    REDRAW_INTERVAL = 0.05 # seconds; throttle fast progress redraws (~20fps)

    # Raw VT100/ANSI control sequences (kept inline to avoid extra gem deps).
    HIDE_CURSOR    = "\e[?25l"
    SHOW_CURSOR    = "\e[?25h"
    SAVE_CURSOR    = "\e7"
    RESTORE_CURSOR = "\e8"
    CLEAR_LINE     = "\e[2K"
    RESET_REGION   = "\e[r"
    # CSI sequences (colours/cursor) and OSC strings emitted by the command.
    ANSI = %r{\e\[[0-9;?]*[ -/]*[@-~]|\e\][^\a]*\a}.freeze

    def initialize(height: nil, output: $stdout)
      @height = height || [TTY::Screen.height / HEIGHT_DIVISOR, MIN_HEIGHT].max
      @output = output
      @buffer = []
      @tag = nil
      @last_draw = 0.0
      @mutex = Mutex.new
    end

    def enabled?
      return @enabled unless @enabled.nil?

      @enabled = @output.tty? && TTY::Screen.height.to_i > @height + MIN_TOP_ROWS
    end

    def setup
      @rows = TTY::Screen.height
      @divider_row = @rows - @height # 1-based row carrying the divider
      @output.sync = true

      write("\e[1;#{@divider_row - 1}r") # confine scrolling to rows above divider
      write(HIDE_CURSOR)

      draw_divider

      # Park the cursor on the last scrolling row so titles appear right above
      # the pane and scroll upward as more are printed.
      write(move(@divider_row - 1, 1))
    end

    def tag=(name)
      @mutex.synchronize { @tag = name }
    end

    def push(line, err: false, progress: false)
      text = sanitize(line)
      return if text.empty?

      @mutex.synchronize do
        entry = { text: text, err: err, tag: @tag, progress: progress }
        last = @buffer.last

        if last && last[:progress] && last[:err] == err && last[:tag] == @tag
          # Redraw the live line in place (next progress frame or its closing newline).
          @buffer[-1] = entry
        else
          @buffer << entry
          @buffer.shift while @buffer.size > @height
        end

        # Throttle fast progress redraws; committed lines always repaint.
        now = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        next if progress && now - @last_draw < REDRAW_INTERVAL

        @last_draw = now
        redraw
      end
    end

    def teardown
      @mutex.synchronize do
        write(RESET_REGION + move(@rows, 1) + SHOW_CURSOR + "\n")
      end
    end

    private

    def redraw
      width = TTY::Screen.width
      frame = +SAVE_CURSOR
      @height.times do |i|
        frame << move(@divider_row + 1 + i, 1) << CLEAR_LINE
        entry = @buffer[i]
        frame << render(entry, width) if entry
      end
      frame << RESTORE_CURSOR
      write(frame)
    end

    # A colourised, width-clipped pane line: "-> [Package] message".
    def render(entry, width)
      label = entry[:tag] ? "[#{entry[:tag]}] " : ''
      budget = [width - 3 - label.length, 1].max # 3 cols for the '-> ' arrow
      body = entry[:text].length > budget ? entry[:text][0, budget] : entry[:text]

      arrow = entry[:err] ? Styles::ERR_PREFIX['-> '] : Styles::OUT_PREFIX['-> ']
      arrow + (label.empty? ? '' : Styles::TAG[label]) + body
    end

    def draw_divider
      msg = ' live output '
      bars = '/' * [TTY::Screen.width - msg.length, 0].max
      write(SAVE_CURSOR + move(@divider_row, 1) + CLEAR_LINE +
            Styles::HEADER_OUT[msg + bars] + RESTORE_CURSOR)
    end

    def move(row, col)
      "\e[#{row};#{col}H"
    end

    # Drop the command's own escape codes / carriage returns so width math and the
    # pane layout stay stable; our own colour is applied via the line prefix.
    def sanitize(line)
      line.to_s.gsub(ANSI, '').tr("\r\b\a\f\v", '').rstrip
    end

    def write(str)
      @output.print(str)
      @output.flush
    end
  end
end
