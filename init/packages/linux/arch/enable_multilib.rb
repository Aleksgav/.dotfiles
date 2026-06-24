# frozen_string_literal: true

module Linux
  module Arch
    # Enable the [multilib] repo (needed for lib32-* packages).
    # No package to install: this uncomments the section in /etc/pacman.conf (idempotent)
    EnableMultilib = Packager::Package::Builder.build do
      title 'Enable multilib repo'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
      post_install "sed -i '/\\[multilib\\]/,/Include/s/^#//' /etc/pacman.conf", sudo: true
      post_install 'pacman -Sy', sudo: true
    end
  end
end
