# frozen_string_literal: true

module Linux
  module Arch
    TexlivePlaingeneric = Packager::Package::Builder.build do
      title 'TeX Live plain generic'
      command 'pacman -S --needed --noconfirm texlive-plaingeneric'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
