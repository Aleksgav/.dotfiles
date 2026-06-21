# frozen_string_literal: true

module Linux
  module Arch
    Virtualbox = Packager::Package::Builder.build do
      title 'Virtualbox'
      command 'pacman -S --needed --noconfirm virtualbox'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      # USB passthrough and host-only networking need the invoking user in the
      # vboxusers group (mirrors how the Docker package wires up its group).
      post_install 'usermod -aG vboxusers "$USER"', sudo: true
    end
  end
end
