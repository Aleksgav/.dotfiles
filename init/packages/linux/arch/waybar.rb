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
    end
  end
end
