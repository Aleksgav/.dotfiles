# frozen_string_literal: true

module Linux
  module Arch
    VirtualboxHostDkms = Packager::Package::Builder.build do
      title 'Virtualbox Host DKMS'
      command 'pacman -S --needed --noconfirm virtualbox-host-dkms'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
