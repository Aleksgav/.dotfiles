# frozen_string_literal: true

module Linux
  module Arch
    Btop = Packager::Package::Builder.build do
      title 'Btop'
      command 'pacman -S --needed --noconfirm btop'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
