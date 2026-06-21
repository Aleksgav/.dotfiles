# frozen_string_literal: true

module Linux
  module Arch
    Audio = Packager::Package::Builder.build do
      title 'Audio (PipeWire)'
      command 'pacman -S --needed --noconfirm ' \
              'sof-firmware alsa-firmware alsa-utils ' \
              'pipewire pipewire-pulse pipewire-jack pipewire-alsa ' \
              'wireplumber pavucontrol'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
