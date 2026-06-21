# frozen_string_literal: true

module Linux
  module Arch
    Sheldon = Packager::Package::Builder.build do
      title 'Sheldon'
      command 'pacman -S --needed --noconfirm sheldon'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install { Linker.link 'sheldon', "#{CONFIG_DIR}/sheldon" }
      post_install 'sheldon lock'
    end
  end
end
