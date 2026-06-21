# frozen_string_literal: true

module Linux
  module Arch
    BaseDevel = Packager::Package::Builder.build do
      title 'Base Devel Tools'
      command 'pacman -S --needed --noconfirm base-devel'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
