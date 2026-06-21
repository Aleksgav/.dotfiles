# frozen_string_literal: true

module Linux
  module Arch
    Vlc = Packager::Package::Builder.build do
      title 'VLC'
      command 'pacman -S --needed --noconfirm vlc'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
