# frozen_string_literal: true

module Linux
  module Arch
    FontNotoEmoji = Packager::Package::Builder.build do
      title 'Font noto emoji'
      command 'pacman -S --needed --noconfirm noto-fonts-emoji'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
