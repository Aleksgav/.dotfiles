# frozen_string_literal: true

module Linux
  module Arch
    Pipewire = Packager::Package::Builder.build do
      title 'PipeWire'
      command 'pacman -S --needed --noconfirm ' \
              'pipewire pipewire-pulse pipewire-jack pipewire-alsa'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
