# frozen_string_literal: true

module Linux
  module Arch
    Wdisplays = Packager::Package::Builder.build do
      title 'wdisplays'
      command 'pacman -S --needed --noconfirm wdisplays'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
