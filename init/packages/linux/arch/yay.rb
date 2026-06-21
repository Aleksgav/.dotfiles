# frozen_string_literal: true

module Linux
  module Arch
    Yay = Packager::Package::Builder.build do
      title 'Yay AUR helper'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false

      command 'rm -rf /tmp/yay && ' \
              'git clone https://aur.archlinux.org/yay.git /tmp/yay && ' \
              'cd /tmp/yay && makepkg -df --noconfirm'

      post_install 'pacman -U --noconfirm /tmp/yay/yay-[0-9]*.pkg.tar.zst', sudo: true
    end
  end
end
