# frozen_string_literal: true

module Linux
  module Arch
    Rtkit = Packager::Package::Builder.build do
      title 'RealtimeKit'
      command 'pacman -S --needed --noconfirm rtkit'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install 'systemctl enable --now rtkit-daemon.service', sudo: true
    end
  end
end
