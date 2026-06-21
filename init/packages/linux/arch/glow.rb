# frozen_string_literal: true

module Linux
  module Arch
    Glow = Packager::Package::Builder.build do
      title 'Glow'
      command 'pacman -S --needed --noconfirm glow'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install { Linker.link 'glow', "#{CONFIG_DIR}/glow" }
    end
  end
end
