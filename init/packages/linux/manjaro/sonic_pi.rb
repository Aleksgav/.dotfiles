# frozen_string_literal: true

module Linux
  module Manjaro
    SonicPi = Packager::Package::Builder.build do
      title 'SonicPI'
      command 'pamac install sonic-pi --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
