# frozen_string_literal: true

module Linux
  module Manjaro
    Skype = Packager::Package::Builder.build do
      title 'Skype'
      command 'snap install skype'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
