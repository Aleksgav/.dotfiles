# frozen_string_literal: true

module Linux
  module Arch
    Mpv = Packager::Package::Builder.build do
      title 'Mpv'
      command 'pacman -S --needed --noconfirm mpv'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install { Linker.link 'mpv', "#{CONFIG_DIR}/mpv" }
    end
  end
end
