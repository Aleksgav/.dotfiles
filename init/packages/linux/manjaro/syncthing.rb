# frozen_string_literal: true

module Linux
  module Manjaro
    Syncthing = Packager::Package::Builder.build do
      title 'Syncthing'
      command 'pamac install syncthing --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
