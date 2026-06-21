# frozen_string_literal: true

module Linux
  module Arch
    Ffmpegthumbnailer = Packager::Package::Builder.build do
      title 'Ffmpegthumbnailer'
      command 'pacman -S --needed --noconfirm ffmpegthumbnailer'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
