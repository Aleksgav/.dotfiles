# frozen_string_literal: true

module Linux
  module Arch
    Appimagelauncher = Packager::Package::Builder.build do
      title 'AppImageLauncher'
      command 'yay -S --needed --noconfirm appimagelauncher'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
