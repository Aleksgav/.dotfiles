# frozen_string_literal: true

module Linux
  module Arch
    Typst = Packager::Package::Builder.build do
      title 'Typst'
      command 'pacman -S --needed --noconfirm typst'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
