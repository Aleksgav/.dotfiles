#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'lib/init'

installator = Executor.new(Packager::ErrPrinter.new(symbol_h: '='))
manjaro_install_command = CLI::Commands::Install[ManjaroMain, installator]
osx_install_command = CLI::Commands::Install[OSXMain, installator]

CLI::Commands.register 'manjaro', manjaro_install_command, aliases: ['manjaro']
CLI::Commands.register 'osx', osx_install_command, aliases: ['osx']

Dry::CLI.new(CLI::Commands).call
