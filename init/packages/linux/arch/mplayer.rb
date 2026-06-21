# frozen_string_literal: true

module Linux
  module Arch
    Mplayer = Packager::Package::Builder.build do
      title 'Mplayer'
      command 'pacman -S --needed --noconfirm mplayer'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
