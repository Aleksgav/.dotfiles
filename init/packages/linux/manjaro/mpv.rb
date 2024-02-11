# frozen_string_literal: true

module Linux
  module Manjaro
    Mpv = Packager::Package::Builder.build do
      title 'Mpv'
      command 'pamac install mpv --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
