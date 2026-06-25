# frozen_string_literal: true

module Linux
  module Arch
    WlClipboard = Packager::Package::Builder.build do
      title 'wl-clipboard'
      command 'pacman -S --needed --noconfirm wl-clipboard'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
