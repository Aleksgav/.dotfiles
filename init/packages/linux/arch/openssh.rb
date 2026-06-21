# frozen_string_literal: true

module Linux
  module Arch
    Openssh = Packager::Package::Builder.build do
      title 'OpenSSH'
      command 'pacman -S --needed --noconfirm openssh'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      # Let the user systemd instance run without an active login (headless/remote boxes),
      # then enable the socket-activated agent. Socket activation starts ssh-agent.service
      # on first connection to $XDG_RUNTIME_DIR/ssh-agent.socket (see .zshrc SSH_AUTH_SOCK).
      post_install 'loginctl enable-linger "$(id -un)"', sudo: true
      post_install 'systemctl --user enable --now ssh-agent.socket'
    end
  end
end
