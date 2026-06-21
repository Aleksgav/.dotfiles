# frozen_string_literal: true

module Linux
  module Arch
    Yazi = Packager::Package::Builder.build do
      title 'Yazi file manager'
      command 'pacman -S --needed --noconfirm yazi'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
