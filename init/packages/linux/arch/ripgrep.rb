# frozen_string_literal: true

module Linux
  module Arch
    Ripgrep = Packager::Package::Builder.build do
      title 'Ripgrep'
      command 'pacman -S --needed --noconfirm ripgrep'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
