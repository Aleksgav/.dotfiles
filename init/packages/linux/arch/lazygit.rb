# frozen_string_literal: true

module Linux
  module Arch
    Lazygit = Packager::Package::Builder.build do
      title 'Lazygit'
      command 'pacman -S --needed --noconfirm lazygit'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
