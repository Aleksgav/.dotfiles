# frozen_string_literal: true

module Linux
  module Arch
    Kmon = Packager::Package::Builder.build do
      title 'Kmon'
      command 'pacman -S --needed --noconfirm kmon'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
