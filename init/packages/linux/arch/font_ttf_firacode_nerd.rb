# frozen_string_literal: true

module Linux
  module Arch
    FontTtfFiracodeNerd = Packager::Package::Builder.build do
      title 'Font TTF Firacode Nerd'
      command 'pacman -S --needed --noconfirm ttf-firacode-nerd'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
