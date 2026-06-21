# frozen_string_literal: true

module Linux
  module Arch
    Xplr = Packager::Package::Builder.build do
      title 'Xplr'
      command 'pacman -S --needed --noconfirm xplr'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
