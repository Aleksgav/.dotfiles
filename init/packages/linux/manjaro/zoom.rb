# frozen_string_literal: true

module Linux
  module Manjaro
    Zoom = Packager::Package::Builder.build do
      title 'Zoom'
      command 'snap install zoom-client'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
