# frozen_string_literal: true

module Linux
  module Arch
    GitUi = Packager::Package::Builder.build do
      title 'Git ui'
      command 'pacman -S --needed --noconfirm gitui'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
