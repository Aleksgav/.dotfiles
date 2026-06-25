# frozen_string_literal: true

module Linux
  module Arch
    Kanshi = Packager::Package::Builder.build do
      title 'kanshi'
      command 'pacman -S --needed --noconfirm kanshi'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
