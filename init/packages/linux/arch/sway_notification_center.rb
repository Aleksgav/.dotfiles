# frozen_string_literal: true

module Linux
  module Arch
    SwayNotificationCenter = Packager::Package::Builder.build do
      title 'SwayNotificationCenter'
      command 'pacman -S --needed --noconfirm swaync'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install { Linker.link 'swaync', "#{CONFIG_DIR}/swaync" }
      post_install 'systemctl --user enable swaync.service'
    end
  end
end
