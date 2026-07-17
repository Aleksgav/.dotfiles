# frozen_string_literal: true

module Linux
  module Arch
    Ntfs3g = Packager::Package::Builder.build do
      title 'ntfs-3g (NTFS filesystem driver)'
      command 'pacman -S --needed --noconfirm ntfs-3g'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
