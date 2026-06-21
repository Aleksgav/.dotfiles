# frozen_string_literal: true

module Linux
  module Arch
    Zsh = Packager::Package::Builder.build do
      title 'Zsh'
      command 'pacman -S --needed --noconfirm zsh'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install { Linker.link '.zshrc', '~/.zshrc' }
      post_install 'chsh -s /usr/bin/zsh', sudo: true
    end
  end
end
