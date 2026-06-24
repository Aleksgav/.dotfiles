# frozen_string_literal: true

module Linux
  module Arch
    Bind = Packager::Package::Builder.build do
      title 'BIND'
      command 'pacman -S --needed --noconfirm bind'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
