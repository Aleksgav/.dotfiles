# frozen_string_literal: true

module Linux
  module Arch
    Discord = Packager::Package::Builder.build do
      title 'Discord'
      command 'pacman -S --needed --noconfirm discord'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
