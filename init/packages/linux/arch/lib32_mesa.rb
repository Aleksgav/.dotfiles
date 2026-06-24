# frozen_string_literal: true

module Linux
  module Arch
    Lib32Mesa = Packager::Package::Builder.build do
      title 'Mesa (32-bit)'
      command 'pacman -S --needed --noconfirm lib32-mesa'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
