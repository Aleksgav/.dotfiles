# frozen_string_literal: true

module Linux
  module Manjaro
    Mplayer = Packager::Package::Builder.build do
      title 'Mplayer'
      command 'pamac install mplayer --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
