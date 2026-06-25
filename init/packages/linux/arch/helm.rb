# frozen_string_literal: true

module Linux
  module Arch
    Helm = Packager::Package::Builder.build do
      title 'Helm'
      command 'pacman -S --needed --noconfirm helm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
