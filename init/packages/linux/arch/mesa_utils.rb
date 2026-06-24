# frozen_string_literal: true

module Linux
  module Arch
    MesaUtils = Packager::Package::Builder.build do
      title 'Mesa utils'
      command 'pacman -S --needed --noconfirm mesa-utils'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
