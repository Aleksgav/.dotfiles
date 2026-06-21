# frozen_string_literal: true

module Linux
  module Arch
    Mc = Packager::Package::Builder.build do
      title 'Midnight commander'
      command 'pacman -S --needed --noconfirm mc'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
