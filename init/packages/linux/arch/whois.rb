# frozen_string_literal: true

module Linux
  module Arch
    Whois = Packager::Package::Builder.build do
      title 'whois'
      command 'pacman -S --needed --noconfirm whois'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
