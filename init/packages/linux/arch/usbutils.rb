# frozen_string_literal: true

module Linux
  module Arch
    Usbutils = Packager::Package::Builder.build do
      title 'usbutils (lsusb)'
      command 'pacman -S --needed --noconfirm usbutils'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
