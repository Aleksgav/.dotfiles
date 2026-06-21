# frozen_string_literal: true

module Linux
  module Arch
    Pipewire = Packager::Package::Builder.build do
      title 'PipeWire'
      # Use the real JACK2 server for JACK instead of pipewire-jack; PipeWire
      # still backs PulseAudio and ALSA. (pipewire-jack conflicts with jack2.)
      command 'pacman -S --needed --noconfirm ' \
              'pipewire pipewire-pulse jack2 pipewire-alsa'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
