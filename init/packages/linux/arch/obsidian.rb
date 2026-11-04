# frozen_string_literal: true

module Linux
  module Arch
    Obsidian = Packager::Package::Builder.build do
      title 'Obsidian'
      command 'pacman -S --needed --noconfirm obsidian'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
