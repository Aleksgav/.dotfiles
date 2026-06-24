# frozen_string_literal: true

module Linux
  module Arch
    Dust = Packager::Package::Builder.build do
      title 'Dust'
      command 'pacman -S --needed --noconfirm dust'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
