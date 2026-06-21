# frozen_string_literal: true

module Linux
  module Arch
    SonicPi = Packager::Package::Builder.build do
      title 'SonicPI'
      command 'yay -S --needed --noconfirm sonic-pi'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
