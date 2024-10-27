# frozen_string_literal: true

module Linux
  module Manjaro
    RubyGems = Packager::Package::Builder.build do
      cmd =<<-CMD
        gem install activesupport
        gem install erb
        gem install gettext
        gem install multi_json
      CMD

      title 'Ruby systemwide gems'
      command cmd
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
