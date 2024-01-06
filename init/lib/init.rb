# frozen_string_literal: true

require 'bundler/setup'

Bundler.require(:default)

loader = Zeitwerk::Loader.new
loader.inflector.inflect("cli" => "CLI")
loader.inflector.inflect("osx" => "OSX")
loader.inflector.inflect("osx_main" => "OSXMain")
loader.push_dir('lib')
loader.push_dir('installations')
loader.push_dir('packages')
loader.setup
