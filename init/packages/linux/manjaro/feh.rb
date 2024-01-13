# frozen_string_literal: true

module Linux
  module Manjaro
    Feh = Packager::Package::Builder.build do
      title 'Feh'
      command 'pamac install feh --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
