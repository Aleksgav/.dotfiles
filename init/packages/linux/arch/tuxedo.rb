# frozen_string_literal: true

module Linux
  module Arch
    Tuxedo = Packager::Package::Builder.build do
      title 'Tuxedo'
      command 'yay -S --needed --noconfirm tuxedo-bin'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
