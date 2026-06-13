# frozen_string_literal: true

module Linux
  module Manjaro
    Picom = Packager::Package::Builder.build do
      title 'Picom'
      command 'pamac install picom --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      # /etc/xdg is root-owned
      post_install 'ln -s $HOME/.dotfiles/picom/picom.conf /etc/xdg/picom.conf', sudo: true
    end
  end
end
