# frozen_string_literal: true

module Linux
  module Arch
    ConntrackTools = Packager::Package::Builder.build do
      title 'conntrack-tools'
      command 'pacman -S --needed --noconfirm conntrack-tools'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
