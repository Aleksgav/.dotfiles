# frozen_string_literal: true

module Linux
  module Arch
    Openssh = Packager::Package::Builder.build do
      title 'OpenSSH'
      command 'pacman -S --needed --noconfirm openssh'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install 'systemctl --user enable --now ssh-agent.service'
    end
  end
end
