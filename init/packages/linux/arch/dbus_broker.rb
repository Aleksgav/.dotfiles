# frozen_string_literal: true

module Linux
  module Arch
    DbusBroker = Packager::Package::Builder.build do
      title 'D-Bus Broker'
      command 'pacman -S --needed --noconfirm dbus-broker dbus-broker-units'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install 'systemctl enable --now dbus-broker.service', sudo: true
      post_install 'systemctl --user enable dbus-broker.service'
    end
  end
end
