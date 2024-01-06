# frozen_string_literal: true

module Packager
  class Package
    class Builder
      class << self
        def build(&block)
          builder = self.new(&block)

          builder.build
        end
      end

      def initialize(&block)
        @package = Package.new

        instance_eval &block
      end

      def build
        package
      end

      private

      attr_reader :package

      def title(title) package.title = title end
      def command(command) package.command = command end
      def target_os(target_os) package.target_os = target_os end
      def target_distro(target_distro) package.target_distro = target_distro end
      def sudo_require(sudo_require) package.sudo_require = sudo_require end

      alias_method :distro, :target_distro
      alias_method :os, :target_os
      alias_method :sudo, :sudo_require
    end

    SUDO_PREFIX = 'sodo -S <<< '

    attr_accessor :title,
                :command,
                :target_os,
                :target_distro,
                :sudo_require

    def install(context)
      command = make_command(context)

      Open3.popen3(command)
    end

    def make_command(context)
      if sudo_require
        SUDO_PREFIX.dup << '"' << context.pass << '" ' << command
      else
        command
      end
    end
  end
end
