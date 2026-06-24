# frozen_string_literal: true

module Linux
  module Arch
    Reflector = Packager::Package::Builder.build do
      title 'Reflector'
      command 'pacman -S --needed --noconfirm reflector'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
