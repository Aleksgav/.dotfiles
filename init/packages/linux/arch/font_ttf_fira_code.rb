# frozen_string_literal: true

module Linux
  module Arch
    FontTtfFiraCode = Packager::Package::Builder.build do
      title 'Font TTF fira code'
      command 'pacman -S --needed --noconfirm ttf-fira-code'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
