#!/usr/bin/env ruby
# frozen_string_literal: true

require 'bundler/setup'

require_relative 'install_osx'
require_relative 'install_manjaro'

Init::CLI::Commands.register 'osx', INSTALL_OSX, aliases: ['osx']
Init::CLI::Commands.register 'manjaro', INSTALL_MANJARO, aliases: ['manjaro']

Dry::CLI.new(Init::CLI::Commands).call
