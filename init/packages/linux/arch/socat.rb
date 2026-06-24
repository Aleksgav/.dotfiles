# frozen_string_literal: true

module Linux
  module Arch
    Socat = Packager::Package::Builder.build do
      title 'socat'
      command 'pacman -S --needed --noconfirm socat'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
