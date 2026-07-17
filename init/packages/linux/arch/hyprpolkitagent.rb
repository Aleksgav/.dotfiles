# frozen_string_literal: true

# Provides the password prompt for admin-gated storage actions (LUKS unlock, internal-disk mounts from Thunar, gparted).

module Linux
  module Arch
    Hyprpolkitagent = Packager::Package::Builder.build do
      title 'hyprpolkitagent (polkit authentication agent)'
      command 'pacman -S --needed --noconfirm hyprpolkitagent'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install 'systemctl --user enable hyprpolkitagent.service'
    end
  end
end
