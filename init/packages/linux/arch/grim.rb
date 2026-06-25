# frozen_string_literal: true

module Linux
  module Arch
    Grim = Packager::Package::Builder.build do
      title 'Grim'
      command 'pacman -S --needed --noconfirm grim'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
