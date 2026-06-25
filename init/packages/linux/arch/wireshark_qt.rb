# frozen_string_literal: true

module Linux
  module Arch
    WiresharkQt = Packager::Package::Builder.build do
      title 'Wireshark'
      command 'pacman -S --needed --noconfirm wireshark-qt'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
