# frozen_string_literal: true

module Linux
  module Arch
    Tealdeer = Packager::Package::Builder.build do
      title 'Tealdeer'
      command 'pacman -S --needed --noconfirm tealdeer'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
