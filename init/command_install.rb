# frozen_string_literal: true

require 'dry/cli'

require_relative 'err_printer'
require_relative 'executor'

module Init
  module CLI
    module Commands
      extend Dry::CLI::Registry

      class Install < Dry::CLI::Command
        desc 'Installation packages && configs'
        option :dry_run, type: :boolean, default: false, desc: 'Dry run mode', aliases: ['d']

        def initialize(&init)
          @executor = Executor.new(ErrPrinter.new(symbol_h: '='))

          init[executor]
        end

        def call(**options)
          executor.run(**options)
        end

        private

        attr_reader :executor
      end
    end
  end
end
