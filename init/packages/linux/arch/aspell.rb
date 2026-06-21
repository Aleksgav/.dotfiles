# frozen_string_literal: true

module Linux
  module Arch
    Aspell = Packager::Package::Builder.build do
      title 'Aspell'
      command 'pacman -S --needed --noconfirm aspell'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
