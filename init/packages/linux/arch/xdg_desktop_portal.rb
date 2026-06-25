# frozen_string_literal: true

module Linux
  module Arch
    XdgDesktopPortal = Packager::Package::Builder.build do
      title 'xdg-desktop-portal'
      command 'pacman -S --needed --noconfirm xdg-desktop-portal'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install { Linker.link 'xdg-desktop-portal', "#{CONFIG_DIR}/xdg-desktop-portal" }
    end
  end
end
