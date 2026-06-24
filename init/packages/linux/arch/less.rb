# frozen_string_literal: true

module Linux
  module Arch
    Less = Packager::Package::Builder.build do
      title 'less'
      command 'pacman -S --needed --noconfirm less'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
