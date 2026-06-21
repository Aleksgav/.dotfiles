# frozen_string_literal: true

module Linux
  module Arch
    Unzip = Packager::Package::Builder.build do
      title 'Unzip'
      command 'pacman -S --needed --noconfirm unzip'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
