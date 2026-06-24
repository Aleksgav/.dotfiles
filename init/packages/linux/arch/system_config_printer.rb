# frozen_string_literal: true

module Linux
  module Arch
    SystemConfigPrinter = Packager::Package::Builder.build do
      title 'System config printer'
      command 'pacman -S --needed --noconfirm system-config-printer'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
