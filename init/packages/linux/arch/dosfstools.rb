# frozen_string_literal: true

module Linux
  module Arch
    Dosfstools = Packager::Package::Builder.build do
      title 'dosfstools (FAT32 filesystem tools)'
      command 'pacman -S --needed --noconfirm dosfstools'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
