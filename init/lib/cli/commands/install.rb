# lib/install.rb

module CLI
  module Commands
    class Install < Dry::CLI::Command
      desc 'Installation packages && configs'
      option :dry_run, type: :boolean, default: false, desc: 'Dry run mode', aliases: ['d']

      attr_reader :installation, :installer

      class << self
        def [](installation, installer)
          new(installation, installer)
        end
      end

      def initialize(installation, installer)
        @installation = installation
        @installer = installer
      end

      def call(**options)
        context = Context.new
        context.pass = read_sudo_password

        installer.run(installation, context, **options.slice(:dry_run))
      end

      private

      def read_sudo_password
        tty = File.open('/dev/tty', 'r+')
        begin
          TTY::Prompt.new(input: tty, output: tty)
                     .mask('Input sudo password:', required: true) { |q| q.modify :chomp }
        ensure
          tty.close
        end
      rescue Errno::ENOENT, Errno::ENXIO, Errno::EIO
        abort('No controlling terminal (/dev/tty) is available, so the sudo password ' \
              "cannot be read.\nRun the installer in an interactive terminal on the VM " \
              '(not through a non-interactive ssh / `vagrant ssh -c` / provisioning command).')
      end
    end
  end
end
