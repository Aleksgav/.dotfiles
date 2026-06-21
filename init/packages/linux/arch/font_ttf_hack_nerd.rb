# frozen_string_literal: true

module Linux
  module Arch
    FontTtfHackNerd = Packager::Package::Builder.build do
      title 'Font TTF Hack nerd'
      command 'pacman -S --needed --noconfirm ttf-hack-nerd'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
