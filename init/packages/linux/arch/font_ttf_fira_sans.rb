# frozen_string_literal: true

module Linux
  module Arch
    FontTtfFiraSans = Packager::Package::Builder.build do
      title 'Font TTF fira sans'
      command 'pacman -S --needed --noconfirm ttf-fira-sans'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
