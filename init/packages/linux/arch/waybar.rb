# frozen_string_literal: true

module Linux
  module Arch
    Waybar = Packager::Package::Builder.build do
      title 'Waybar'
      command 'pacman -S --needed --noconfirm waybar'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install { Linker.link 'waybar', "#{CONFIG_DIR}/waybar" }
      # Run waybar as a systemd user service instead of mango's exec-once.
      # The unit (ships with the package) is WantedBy=graphical-session.target with
      # Restart=on-failure, so uwsm starts it with the session, restarts it if it
      # crashes, and stops it on logout.
      post_install 'systemctl --user enable waybar.service'
      # The keyboard-state module (caps-lock indicator) reads /dev/input via libevdev,
      # which is restricted to the `input` group -- add the user so it works after relogin
      # (same pattern as docker/virtualbox group setup).
      post_install 'usermod -aG input "$USER"', sudo: true
    end
  end
end
