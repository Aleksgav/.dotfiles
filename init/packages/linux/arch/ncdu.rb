# frozen_string_literal: true

module Linux
  module Arch
    Ncdu = Packager::Package::Builder.build do
      title 'Ncdu'
      command 'pacman -S --needed --noconfirm ncdu'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
