# frozen_string_literal: true

module Linux
  module Arch
    TlpRdw = Packager::Package::Builder.build do
      title 'TLP RDW'
      command 'pacman -S --needed --noconfirm tlp-rdw'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      # tlp-rdw pulls in NetworkManager; its dispatcher drives radio switching.
      post_install 'systemctl enable NetworkManager-dispatcher.service', sudo: true
      # Mask systemd-rfkill so it doesn't conflict with TLP's radio-device handling.
      post_install 'systemctl mask systemd-rfkill.service', sudo: true
      post_install 'systemctl mask systemd-rfkill.socket', sudo: true
      # Only install on laptops
      chassis :laptop
    end
  end
end
