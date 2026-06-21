# frozen_string_literal: true

module Linux
  module Arch
    Tealdeer = Packager::Package::Builder.build do
      title 'Tealdeer'
      # ask=4 - overwrite if already present
      command 'pacman -S --needed --noconfirm --ask=4 tealdeer'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
