# frozen_string_literal: true

module Linux
  module Arch
    Hyprlock = Packager::Package::Builder.build do
      title 'Hyprlock'
      command 'pacman -S --needed --noconfirm hyprlock'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install { Linker.link 'hypr', "#{CONFIG_DIR}/hypr" }
    end
  end
end
