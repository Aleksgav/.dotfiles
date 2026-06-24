# frozen_string_literal: true

module Linux
  module Arch
    Mtr = Packager::Package::Builder.build do
      title 'mtr'
      command 'pacman -S --needed --noconfirm mtr'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
