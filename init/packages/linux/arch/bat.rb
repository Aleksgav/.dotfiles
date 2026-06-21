# frozen_string_literal: true

module Linux
  module Arch
    Bat = Packager::Package::Builder.build do
      title 'Bat'
      command 'pacman -S --needed --noconfirm bat'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install { Linker.link 'bat', "#{CONFIG_DIR}/bat" }
    end
  end
end
