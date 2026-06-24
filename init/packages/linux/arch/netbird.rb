# frozen_string_literal: true

module Linux
  module Arch
    Netbird = Packager::Package::Builder.build do
      title 'NetBird'
      command 'yay -S --needed --noconfirm netbird'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
      # Client daemon uses a templated unit (netbird@<profile>); start the
      # default profile. It idles until `netbird up` authenticates.
      post_install 'systemctl enable --now netbird@default.service', sudo: true
    end
  end
end
