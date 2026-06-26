# frozen_string_literal: true

module Linux
  module Arch
    # Apple Magic Trackpad 2 (USB + Bluetooth) driver tuning.
    # No package to install: hid_magicmouse is in-tree and the Bluetooth stack (bluez*) is already pulled in elsewhere.
    # This just drops a modprobe.d config so the driver's wheel/button emulation stays out of libinput's way.
    AppleMagicTrackpad = Packager::Package::Builder.build do
      title 'Apple Magic Trackpad 2'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
      post_install 'ln -sf "$HOME/.dotfiles/modprobe.d/hid_magicmouse.conf" /etc/modprobe.d/hid_magicmouse.conf',
                   sudo: true
    end
  end
end
