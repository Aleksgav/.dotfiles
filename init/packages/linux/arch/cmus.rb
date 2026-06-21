# frozen_string_literal: true

module Linux
  module Arch
    Cmus = Packager::Package::Builder.build do
      title 'Cmus'
      command 'pacman -S --needed --noconfirm cmus'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
