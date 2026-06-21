# frozen_string_literal: true

module Linux
  module Arch
    Docker = Packager::Package::Builder.build do
      title 'Docker'
      command 'pacman -S --needed --noconfirm docker'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install 'systemctl enable --now docker.service', sudo: true
      post_install 'usermod -aG docker "$USER"', sudo: true
    end
  end
end
