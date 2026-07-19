# frozen_string_literal: true

module Linux
  module Arch
    Traceroute = Packager::Package::Builder.build do
      title 'traceroute'
      command 'pacman -S --needed --noconfirm traceroute'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
