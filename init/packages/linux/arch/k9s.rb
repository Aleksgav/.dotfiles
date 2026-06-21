# frozen_string_literal: true

module Linux
  module Arch
    K9s = Packager::Package::Builder.build do
      title 'K9s'
      command 'pacman -S --needed --noconfirm k9s'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
