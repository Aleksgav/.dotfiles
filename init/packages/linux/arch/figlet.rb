# frozen_string_literal: true

module Linux
  module Arch
    Figlet = Packager::Package::Builder.build do
      title 'Figlet'
      command 'pacman -S --needed --noconfirm figlet'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
