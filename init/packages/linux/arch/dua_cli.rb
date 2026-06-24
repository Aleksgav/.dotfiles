# frozen_string_literal: true

module Linux
  module Arch
    DuaCli = Packager::Package::Builder.build do
      title 'Dua CLI'
      command 'pacman -S --needed --noconfirm dua-cli'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
