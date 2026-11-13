#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'lib/init'

user_bindirs = %w[~/.cargo/bin ~/go/bin].map { |dir| File.expand_path(dir) }
ENV['PATH'] = (user_bindirs + ENV.fetch('PATH', '').split(File::PATH_SEPARATOR))
              .uniq
              .join(File::PATH_SEPARATOR)

# Fresh TTY/SSH runs have no XDG_STATE_HOME (uwsm and sheldon's autoenv set it only inside a session/zsh).
ENV['XDG_STATE_HOME'] = File.expand_path('~/.local/state') if ENV.fetch('XDG_STATE_HOME', '').empty?

installator = Executor.new
manjaro_install_command = CLI::Commands::Install[ManjaroMain, installator]
arch_install_command = CLI::Commands::Install[ArchMain, installator]
osx_install_command = CLI::Commands::Install[OSXMain, installator]

CLI::Commands.register 'manjaro', manjaro_install_command, aliases: ['manjaro']
CLI::Commands.register 'arch', arch_install_command, aliases: ['arch']
CLI::Commands.register 'osx', osx_install_command, aliases: ['osx']

Dry::CLI.new(CLI::Commands).call
