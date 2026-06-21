# frozen_string_literal: true

module Linux
  module Arch
    VirtualboxGuestUtils = Packager::Package::Builder.build do
      title 'Virtualbox Guest Utils'
      command 'pacman -S --needed --noconfirm virtualbox-guest-utils'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
