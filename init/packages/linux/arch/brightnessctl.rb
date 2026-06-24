# frozen_string_literal: true

module Linux
  module Arch
    Brightnessctl = Packager::Package::Builder.build do
      title 'brightnessctl'
      command 'pacman -S --needed --noconfirm brightnessctl'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
