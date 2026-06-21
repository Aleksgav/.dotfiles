# frozen_string_literal: true

module Linux
  module Arch
    Curlie = Packager::Package::Builder.build do
      title 'Curlie'
      command 'pacman -S --needed --noconfirm curlie'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
