# frozen_string_literal: true

module Linux
  module Arch
    Htop = Packager::Package::Builder.build do
      title 'Htop'
      command 'pacman -S --needed --noconfirm htop'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
