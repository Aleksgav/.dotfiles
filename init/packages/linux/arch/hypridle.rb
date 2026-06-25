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
    end
  end
end
