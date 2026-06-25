# frozen_string_literal: true

module Linux
  module Arch
    NetworkManagerApplet = Packager::Package::Builder.build do
      title 'Network Manager Applet'
      command 'pacman -S --needed --noconfirm network-manager-applet'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
