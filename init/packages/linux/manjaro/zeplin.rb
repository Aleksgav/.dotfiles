# frozen_string_literal: true

module Linux
  module Manjaro
    Zeplin = Packager::Package::Builder.build do
      title 'Zeplin'
      command 'snap install zeplin'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
