# frozen_string_literal: true

module Packager
  class Package
    SUDO_PREFIX = "sudo -S -p '' "

    Step = Struct.new(:command, :sudo_require, :label_suffix, keyword_init: true) do
      def run(context)
        # Instead of exception get error 127
        stdin, stdout, stderr, wait_thr = Open3.popen3('sh', '-c', make_command)

        feed_password(stdin, context.pass) if sudo_require
        stdin.close

        [stdin, stdout, stderr, wait_thr]
      end

      private

      def make_command
        sudo_require ? SUDO_PREFIX + command : command
      end

      def feed_password(stdin, pass)
        stdin.sync = true # broken pipe surface fast fail
        stdin.puts(pass)
      rescue Errno::EPIPE
        # cached sudo creds
      end
    end

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

      # Optional steps
      # Each call appends a step
      def pre_install(command, sudo: false)
        package.pre_install << Step.new(command: command, sudo_require: sudo, label_suffix: 'pre')
      end

      def post_install(command, sudo: false)
        package.post_install << Step.new(command: command, sudo_require: sudo, label_suffix: 'post')
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
    def steps
      [*pre_install, main_step, *post_install]
    end

    private

    def main_step
      Step.new(command: command, sudo_require: sudo_require, label_suffix: nil)
    end
  end
end
