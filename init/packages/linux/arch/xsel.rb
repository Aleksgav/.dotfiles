# frozen_string_literal: true

module Linux
  module Arch
    Xsel = Packager::Package::Builder.build do
      title 'Xsel'
      command 'pacman -S --needed --noconfirm xsel'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
