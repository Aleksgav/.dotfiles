# frozen_string_literal: true

module Linux
  module Arch
    Zellij = Packager::Package::Builder.build do
      title 'Zellij'
      command 'pacman -S --needed --noconfirm zellij'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install { Linker.link 'zellij', "#{CONFIG_DIR}/zellij" }
    end
  end
end
