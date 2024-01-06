# frozen_string_literal: true

module Linux
  module Manjaro
    RubyRubocop = Packager::Package::Builder.build do
      title 'Rubocop (Ruby static code analyser)'
      command 'gem install rubocop'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
