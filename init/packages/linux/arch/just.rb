# frozen_string_literal: true

module Linux
  module Arch
    Just = Packager::Package::Builder.build do
      title 'Just runner'
      command 'pacman -S --needed --noconfirm just'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
