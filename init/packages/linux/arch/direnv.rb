# frozen_string_literal: true

module Linux
  module Arch
    Direnv = Packager::Package::Builder.build do
      title 'Direnv'
      command 'pacman -S --needed --noconfirm direnv'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
