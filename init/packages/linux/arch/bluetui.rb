# frozen_string_literal: true

module Linux
  module Arch
    Bluetui = Packager::Package::Builder.build do
      title 'Bluetui'
      command 'pacman -S --needed --noconfirm bluetui'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
