# frozen_string_literal: true

module Linux
  module Arch
    Imv = Packager::Package::Builder.build do
      title 'Imv'
      command 'pacman -S --needed --noconfirm imv'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install { Linker.link 'imv', "#{CONFIG_DIR}/imv" }
      post_install 'xdg-mime default imv.desktop image/jpeg image/png image/gif image/webp'
    end
  end
end
