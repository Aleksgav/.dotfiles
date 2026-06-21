# frozen_string_literal: true

module Linux
  module Arch
    Httpie = Packager::Package::Builder.build do
      title 'Httpie'
      command 'pacman -S --needed --noconfirm httpie'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
