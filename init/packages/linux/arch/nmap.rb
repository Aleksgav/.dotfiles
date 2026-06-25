# frozen_string_literal: true

module Linux
  module Arch
    Nmap = Packager::Package::Builder.build do
      title 'Nmap'
      command 'pacman -S --needed --noconfirm nmap'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
