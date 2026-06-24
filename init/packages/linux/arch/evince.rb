# frozen_string_literal: true

module Linux
  module Arch
    Evince = Packager::Package::Builder.build do
      title 'Evince'
      command 'pacman -S --needed --noconfirm evince'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
