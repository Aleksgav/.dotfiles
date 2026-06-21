# frozen_string_literal: true

module Linux
  module Arch
    GpgTui = Packager::Package::Builder.build do
      title 'Gpg Tui'
      command 'pacman -S --needed --noconfirm gpg-tui'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
