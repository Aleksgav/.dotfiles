# frozen_string_literal: true

module Linux
  module Arch
    XdgDesktopPortalWlr = Packager::Package::Builder.build do
      title 'xdg-desktop-portal-wlr'
      command 'pacman -S --needed --noconfirm xdg-desktop-portal-wlr'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install { Linker.link 'xdg-desktop-portal-wlr', "#{CONFIG_DIR}/xdg-desktop-portal-wlr" }
    end
  end
end
