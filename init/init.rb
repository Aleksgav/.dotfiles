#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'lib/init'

user_bindirs = %w[~/.cargo/bin ~/go/bin].map { |dir| File.expand_path(dir) }
ENV['PATH'] = (user_bindirs + ENV.fetch('PATH', '').split(File::PATH_SEPARATOR))
              .uniq
              .join(File::PATH_SEPARATOR)

installator = Executor.new
manjaro_install_command = CLI::Commands::Install[ManjaroMain, installator]
osx_install_command = CLI::Commands::Install[OSXMain, installator]

CLI::Commands.register 'manjaro', manjaro_install_command, aliases: ['manjaro']
CLI::Commands.register 'osx', osx_install_command, aliases: ['osx']

Dry::CLI.new(CLI::Commands).call
