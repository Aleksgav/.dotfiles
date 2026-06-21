# frozen_string_literal: true

module Linux
  module Arch
    Alacritty = Packager::Package::Builder.build do
      title 'Alacritty'
      command 'pacman -S --needed --noconfirm alacritty'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install { Linker.link 'alacritty', "#{CONFIG_DIR}/alacritty" }
    end
  end
end
