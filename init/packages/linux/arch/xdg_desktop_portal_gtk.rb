# frozen_string_literal: true

module Linux
  module Arch
    XdgDesktopPortalGtk = Packager::Package::Builder.build do
      title 'xdg-desktop-portal-gtk'
      command 'pacman -S --needed --noconfirm xdg-desktop-portal-gtk'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
