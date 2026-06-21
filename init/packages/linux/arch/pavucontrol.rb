# frozen_string_literal: true

module Linux
  module Arch
    Pavucontrol = Packager::Package::Builder.build do
      title 'PulseAudio Volume Control'
      command 'pacman -S --needed --noconfirm pavucontrol'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
