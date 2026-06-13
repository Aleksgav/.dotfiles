# frozen_string_literal: true

module Packager
  # A step executed in-process as a Ruby block. Runs as the current user
  # It cannot elevate privileged with sudo.
  class RubyStep
    attr_reader :label_suffix

    def initialize(block:, label_suffix: nil)
      @block = block
      @label_suffix = label_suffix
    end

    def execute(_context)
      @block.call
      Result.new(out: '', err: '', ok: true)
    rescue StandardError => e
      Result.new(out: '', err: "#{e.class}: #{e.message}", ok: false)
    end
  end
end
