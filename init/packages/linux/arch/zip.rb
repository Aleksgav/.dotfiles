# frozen_string_literal: true

module Linux
  module Arch
    Zip = Packager::Package::Builder.build do
      title 'Zip'
      command 'pacman -S --needed --noconfirm zip'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
