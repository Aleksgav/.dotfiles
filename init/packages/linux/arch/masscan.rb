# frozen_string_literal: true

module Linux
  module Arch
    Masscan = Packager::Package::Builder.build do
      title 'Masscan'
      command 'pacman -S --needed --noconfirm masscan'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
