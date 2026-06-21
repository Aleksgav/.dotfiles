# frozen_string_literal: true

module Linux
  module Arch
    Gopls = Packager::Package::Builder.build do
      title 'Gopls'
      command 'pacman -S --needed --noconfirm gopls'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
