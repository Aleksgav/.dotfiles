# frozen_string_literal: true

module Linux
  module Arch
    Firefox = Packager::Package::Builder.build do
      title 'Firefox'
      command 'pacman -S --needed --noconfirm firefox'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
