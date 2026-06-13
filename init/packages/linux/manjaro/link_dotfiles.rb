# frozen_string_literal: true

module Linux
  module Manjaro
    LinkDotfiles = Packager::Package::Builder.build do
      link = <<~CMD
        export DOTFILES=$HOME/.dotfiles

        mv -f $HOME/.vimrc{,.bak}
        ln -s $DOTFILES/.vimrc            $HOME/.vimrc

        mkdir -p ~/.ssh

        ln -s $DOTFILES/mise ~/.config/mise

        ln -s $DOTFILES/.Xresources ~/.Xresources
      CMD

      title 'Global links'
      command 'cp -f $HOME/.dotfiles/xorg.conf.d/00-keyboard.conf /etc/X11/xorg.conf.d/'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install link
    end
  end
end
