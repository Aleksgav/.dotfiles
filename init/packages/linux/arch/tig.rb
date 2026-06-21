# frozen_string_literal: true

module Linux
  module Arch
    Tig = Packager::Package::Builder.build do
      title 'Tig'
      command 'pacman -S --needed --noconfirm tig'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
