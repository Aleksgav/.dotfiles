# frozen_string_literal: true

module Linux
  module Manjaro
    LinkDotfiles = Packager::Package::Builder.build do
      cmd =<<-CMD
        export DOTFILES=$HOME/.dotfiles
        export CONFIG_DIR=#{CONFIG_DIR}

        mv -f $HOME/.gitignore-system{,.bak}
        ln -s $DOTFILES/.gitignore-system $HOME/.gitignore-system

        mv -f $HOME/.gitconfig{,.bak}
        ln -s $DOTFILES/.gitconfig        $HOME/.gitconfig

        mv -f $HOME/.tmux.conf{,.bak}
        ln -s $DOTFILES/.tmux.conf        $HOME/.tmux.conf

        mv -f $HOME/.tmux.linux.conf{,.bak}
        ln -s $DOTFILES/.tmux.linux.conf  $HOME/.tmux.linux.conf

        mv -f /usr/local/bin/tmx{,.bak}
        ln -s $DOTFILES/tmx               /usr/local/bin/tmx

        mv -f $HOME/.gemrc{,.bak}
        ln -s $DOTFILES/.gemrc            $HOME/.gemrc

        mv -f $HOME/.vimrc{,.bak}
        ln -s $DOTFILES/.vimrc            $HOME/.vimrc

        mv -f $HOME/.zshrc{,.bak}
        ln -s $DOTFILES/.zshrc            $HOME/.zshrc

        mv -f $CONFIG_DIR/doom{,.bak}
        ln -s $DOTFILES/.doom.d           $CONFIG_DIR/doom

        mv -f $CONFIG_DIR/starship.toml{,.bak}
        ln -s $DOTFILES/starship.toml     $CONFIG_DIR/starship.toml

        mv -f $HOME/.gitconfig_delta{,.bak}
        ln -s $DOTFILES/.gitconfig_delta  $HOME/.gitconfig_delta

        mv -f $CONFIG_DIR/sheldon{,.bak}
        ln -s $DOTFILES/sheldon           $CONFIG_DIR/sheldon

        mv -f $CONFIG_DIR/alacritty{,.bak}
        ln -s $DOTFILES/alacritty         $CONFIG_DIR/alacritty

        mv -f $CONFIG_DIR/zellij{,.bak}
        ln -s $DOTFILES/zellij            $CONFIG_DIR/zellij

        ln -s $DOTFILES/autostart/conky.desktop $CONFIG_DIR/autostart/conky.desktop
        ln -s $DOTFILES/conky             $CONFIG_DIR/conky

        mv -f $CONFIG_DIR/nvim{,.bak}
        mv ~/.local/share/nvim{,.bak}
        mv ~/.local/state/nvim{,.bak}
        mv ~/.cache/nvim{,.bak}
      CMD

      title 'Link Dotfiles'
      command cmd
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
