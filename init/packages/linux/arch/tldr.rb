# frozen_string_literal: true

module Linux
  module Arch
    Tldr = Packager::Package::Builder.build do
      title 'Tldr'
      command 'pacman -S --needed --noconfirm tldr'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
