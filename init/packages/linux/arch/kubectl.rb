# frozen_string_literal: true

module Linux
  module Arch
    Kubectl = Packager::Package::Builder.build do
      title 'Kubectl'
      command 'pacman -S --needed --noconfirm kubectl'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
