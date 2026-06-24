# frozen_string_literal: true

module Linux
  module Arch
    Powertop = Packager::Package::Builder.build do
      title 'PowerTOP'
      command 'pacman -S --needed --noconfirm powertop'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
