# frozen_string_literal: true

module Linux
  module Arch
    Pass = Packager::Package::Builder.build do
      title 'Pass'
      command 'pacman -S --needed --noconfirm pass'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
