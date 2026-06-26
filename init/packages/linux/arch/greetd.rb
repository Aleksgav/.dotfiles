# frozen_string_literal: true

module Linux
  module Arch
    Greetd = Packager::Package::Builder.build do
      title 'greetd (login manager)'
      command 'pacman -S --needed --noconfirm greetd'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install 'ln -sfn "$HOME/.dotfiles/greetd/config.toml" /etc/greetd/config.toml', sudo: true
      post_install 'install -Dm644 "$HOME/.dotfiles/greetd/mango.desktop" /usr/share/wayland-sessions/mango.desktop', sudo: true
      post_install 'install -Dm644 "$HOME/.dotfiles/greetd/mango-uwsm.desktop" /usr/share/wayland-sessions/mango-uwsm.desktop', sudo: true
      post_install 'systemctl enable greetd.service', sudo: true
    end
  end
end
