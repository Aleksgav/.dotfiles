# frozen_string_literal: true

module Linux
  module Arch
    Conky = Packager::Package::Builder.build do
      title 'Conky'
      command 'pacman -S --needed --noconfirm conky'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install do
        Linker.link 'autostart/conky.desktop', "#{CONFIG_DIR}/autostart/conky.desktop"
        Linker.link 'conky', "#{CONFIG_DIR}/conky"
      end
    end
  end
end
