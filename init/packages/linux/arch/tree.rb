# frozen_string_literal: true

module Linux
  module Arch
    Tree = Packager::Package::Builder.build do
      title 'Tree'
      command 'pacman -S --needed --noconfirm tree'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
