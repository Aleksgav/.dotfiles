# frozen_string_literal: true

module Linux
  module Arch
    Wget = Packager::Package::Builder.build do
      title 'Wget'
      command 'pacman -S --needed --noconfirm wget'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
