# frozen_string_literal: true

module Linux
  module Arch
    Hydra = Packager::Package::Builder.build do
      title 'Hydra'
      command 'pacman -S --needed --noconfirm hydra'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
