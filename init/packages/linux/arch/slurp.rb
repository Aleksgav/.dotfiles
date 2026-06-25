# frozen_string_literal: true

module Linux
  module Arch
    Slurp = Packager::Package::Builder.build do
      title 'Slurp'
      command 'pacman -S --needed --noconfirm slurp'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
