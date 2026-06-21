# frozen_string_literal: true

module Linux
  module Arch
    Nushell = Packager::Package::Builder.build do
      title 'Nushell'
      command 'pacman -S --needed --noconfirm nushell'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
