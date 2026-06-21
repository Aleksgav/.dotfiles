# frozen_string_literal: true

module Linux
  module Arch
    Tokei = Packager::Package::Builder.build do
      title 'Tokei'
      command 'pacman -S --needed --noconfirm tokei'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
