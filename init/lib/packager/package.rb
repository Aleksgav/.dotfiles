# frozen_string_literal: true

module Packager
  class Package
    class Builder
      class << self
        def build(&block)
          builder = new(&block)

          builder.build
        end
      end

      def initialize(&block)
        @package = Package.new

        instance_eval(&block)
      end

      def build
        package
      end

      private

      attr_reader :package

      def title(title)
        package.title = title
      end

      def command(command)
        package.command = command
      end

      def target_os(target_os)
        package.target_os = target_os
      end

      def target_distro(target_distro)
        package.target_distro = target_distro
      end

      def sudo_require(sudo_require)
        package.sudo_require = sudo_require
      end

      # Optional steps. Each call appends a step.
      # Pass a shell string (optionally `sudo: true`) or a Ruby block.
      def pre_install(command = nil, sudo: false, &block)
        package.pre_install << step(command, sudo: sudo, label_suffix: 'pre', &block)
      end

      def post_install(command = nil, sudo: false, &block)
        package.post_install << step(command, sudo: sudo, label_suffix: 'post', &block)
      end

      def step(command, sudo:, label_suffix:, &block)
        return RubyStep.new(block: block, label_suffix: label_suffix) if block

        ShellStep.new(command: command, sudo_require: sudo, label_suffix: label_suffix)
      end

      alias distro target_distro
      alias os target_os
      alias sudo sudo_require
    end

    attr_accessor :title,
                  :command,
                  :target_os,
                  :target_distro,
                  :sudo_require,
                  :pre_install,
                  :post_install

    def initialize
      @pre_install = []
      @post_install = []
    end

    # Ordered executable steps: [pre] -> main -> [post].
    # The main step can be omitted for step-only packages (no `command`).
    def steps
      [*pre_install, *main_step, *post_install]
    end

    private

    def main_step
      return [] unless command

      [ShellStep.new(command: command, sudo_require: sudo_require, label_suffix: nil)]
    end
  end
end
