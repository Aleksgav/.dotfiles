# frozen_string_literal: true

module Linux
  module Arch
    Blueman = Packager::Package::Builder.build do
      title 'Blueman'
      command 'pacman -S --needed --noconfirm blueman'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
