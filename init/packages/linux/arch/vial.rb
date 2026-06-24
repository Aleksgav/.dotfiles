# frozen_string_literal: true

module Linux
  module Arch
    Vial = Packager::Package::Builder.build do
      title 'Vial'
      command 'yay -S --needed --noconfirm vial-appimage'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
