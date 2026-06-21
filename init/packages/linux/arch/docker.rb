# frozen_string_literal: true

module Linux
  module Arch
    Docker = Packager::Package::Builder.build do
      title 'Docker'
      command 'pacman -S --needed --noconfirm docker'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
