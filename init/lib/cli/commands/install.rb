# lib/install.rb

module CLI
  module Commands
    class Install < Dry::CLI::Command
      desc 'Installation packages && configs'
      option :dry_run, type: :boolean, default: false, desc: 'Dry run mode', aliases: ['d']

      attr_reader :installation
      attr_reader :installator

      class << self
        def [](installation, installator)
          new(installation, installator)
        end
      end

      def initialize(installation, installator)
        @installation = installation
        @installator = installator
      end

      def call(**options)
        CONTEXT.pass = TTY::Prompt.new.mask('Input sudo password:', required: true) do |val|
          val.modify :chomp
        end

        installator.run(installation, **options.slice(:dry_run))
      end
    end
  end
end
