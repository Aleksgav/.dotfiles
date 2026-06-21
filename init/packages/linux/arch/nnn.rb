# frozen_string_literal: true

module Linux
  module Arch
    Nnn = Packager::Package::Builder.build do
      title 'Nnn'
      command 'pacman -S --needed --noconfirm nnn'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
