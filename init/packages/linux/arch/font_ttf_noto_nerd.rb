# frozen_string_literal: true

module Linux
  module Arch
    FontTtfNotoNerd = Packager::Package::Builder.build do
      title 'Font TTF noto nerd'
      command 'pacman -S --needed --noconfirm ttf-noto-nerd'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
