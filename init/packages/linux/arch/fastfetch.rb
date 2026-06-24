# frozen_string_literal: true

module Linux
  module Arch
    Fastfetch = Packager::Package::Builder.build do
      title 'Fastfetch'
      command 'pacman -S --needed --noconfirm fastfetch'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
