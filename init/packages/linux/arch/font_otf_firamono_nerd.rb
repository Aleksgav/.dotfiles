# frozen_string_literal: true

module Linux
  module Arch
    FontOtfFiramonoNerd = Packager::Package::Builder.build do
      title 'Font OTF fira mono nerd'
      command 'pacman -S --needed --noconfirm otf-firamono-nerd'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
