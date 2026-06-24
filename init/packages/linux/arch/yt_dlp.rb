# frozen_string_literal: true

module Linux
  module Arch
    YtDlp = Packager::Package::Builder.build do
      title 'YtDlp'
      command 'pacman -S --needed --noconfirm yt-dlp'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
