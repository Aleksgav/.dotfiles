# frozen_string_literal: true

module Linux
  module Arch
    Xclip = Packager::Package::Builder.build do
      title 'Xclip'
      command 'pacman -S --needed --noconfirm xclip'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
