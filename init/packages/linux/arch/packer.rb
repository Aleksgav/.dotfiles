# frozen_string_literal: true

module Linux
  module Arch
    Packer = Packager::Package::Builder.build do
      title 'Packer'
      command 'pacman -S --needed --noconfirm packer'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
