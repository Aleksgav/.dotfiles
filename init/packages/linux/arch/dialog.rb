# frozen_string_literal: true

module Linux
  module Arch
    Dialog = Packager::Package::Builder.build do
      title 'dialog'
      command 'pacman -S --needed --noconfirm dialog'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
