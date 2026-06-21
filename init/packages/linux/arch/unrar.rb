# frozen_string_literal: true

module Linux
  module Arch
    Unrar = Packager::Package::Builder.build do
      title 'Unrar'
      command 'pacman -S --needed --noconfirm unrar'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
