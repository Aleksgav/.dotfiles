# frozen_string_literal: true

module Linux
  module Arch
    TexliveBin = Packager::Package::Builder.build do
      title 'TeX Live binaries'
      command 'pacman -S --needed --noconfirm texlive-bin'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
