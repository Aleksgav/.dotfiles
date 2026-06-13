# frozen_string_literal: true

module Linux
  module Manjaro
    Tmux = Packager::Package::Builder.build do
      link = <<~CMD
        export DOTFILES=$HOME/.dotfiles

        mv -f $HOME/.tmux.conf{,.bak}
        ln -s $DOTFILES/.tmux.conf        $HOME/.tmux.conf

        mv -f $HOME/.tmux.linux.conf{,.bak}
        ln -s $DOTFILES/.tmux.linux.conf  $HOME/.tmux.linux.conf
      CMD

      title 'Tmux'
      command 'pamac install tmux --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install link
      # tmx wrapper lives in a root owned dir
      post_install 'mv -f /usr/local/bin/tmx{,.bak}; ln -s $HOME/.dotfiles/tmx /usr/local/bin/tmx', sudo: true
    end
  end
end
