# frozen_string_literal: true

module Linux
  module Arch
    IntelUcode = Packager::Package::Builder.build do
      title 'Intel microcode'
      command 'pacman -S --needed --noconfirm intel-ucode'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
