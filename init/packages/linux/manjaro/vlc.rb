# frozen_string_literal: true

module Linux
  module Manjaro
    Vlc = Packager::Package::Builder.build do
      title 'VLC'
      command 'pamac install vlc --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
