# frozen_string_literal: true

module Linux
  module Arch
    Zaproxy = Packager::Package::Builder.build do
      title 'OWASP ZAP'
      command 'pacman -S --needed --noconfirm zaproxy'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
