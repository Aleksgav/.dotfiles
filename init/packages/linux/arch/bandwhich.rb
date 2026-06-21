# frozen_string_literal: true

module Linux
  module Arch
    Bandwhich = Packager::Package::Builder.build do
      title 'Bandwhich'
      command 'pacman -S --needed --noconfirm bandwhich'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
