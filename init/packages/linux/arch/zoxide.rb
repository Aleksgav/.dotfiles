# frozen_string_literal: true

module Linux
  module Arch
    Zoxide = Packager::Package::Builder.build do
      title 'Zoxide'
      command 'pacman -S --needed --noconfirm zoxide'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
