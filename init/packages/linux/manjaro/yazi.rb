# frozen_string_literal: true

module Linux
  module Manjaro
    Yazi = Packager::Package::Builder.build do
      title 'Yazi file manager'
      command 'pamac install yazi --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
