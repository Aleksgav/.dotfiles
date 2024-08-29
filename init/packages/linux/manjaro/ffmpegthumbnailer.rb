# frozen_string_literal: true

module Linux
  module Manjaro
    Ffmpegthumbnailer = Packager::Package::Builder.build do
      title 'Ffmpegthumbnailer'
      command 'pamac install ffmpegthumbnailer --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
