# frozen_string_literal: true

module Linux
  module Arch
    Dysk = Packager::Package::Builder.build do
      title 'Dysk'
      command 'pacman -S --needed --noconfirm dysk'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
