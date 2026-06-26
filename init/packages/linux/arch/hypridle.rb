# frozen_string_literal: true

module Linux
  module Arch
    Hypridle = Packager::Package::Builder.build do
      title 'Hypridle'
      command 'pacman -S --needed --noconfirm hypridle'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install { Linker.link 'hypr', "#{CONFIG_DIR}/hypr" }
      # Run hypridle as a systemd user service instead of mango's exec-once.
      # The unit (ships with the package) is WantedBy=graphical-session.target,
      # guarded by ConditionEnvironment=WAYLAND_DISPLAY and Restart=on-failure,
      # so uwsm starts it with the session and stops it on logout.
      post_install 'systemctl --user enable hypridle.service'
    end
  end
end
