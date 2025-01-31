# frozen_string_literal: true

module OSX
  module Any
    LinkDotfiles = Packager::Package::Builder.build do
      cmd =<<-CMD
            export DOTFILES=$HOME/.dotfiles
            export CONFIG_DIR=#{CONFIG_DIR}

            ln -s $DOTFILES/Brewfile          $HOME/Brewfile
            ln -s $DOTFILES/.gitignore-system $HOME/.gitignore-system
            ln -s $DOTFILES/.gitconfig        $HOME/.gitconfig
            ln -s $DOTFILES/.tmux.conf        $HOME/.tmux.conf
            ln -s $DOTFILES/.tmux.osx.conf    $HOME/.tmux.osx.conf
            ln -s $DOTFILES/.tmux.linux.conf  $HOME/.tmux.linux.conf
            ln -s $DOTFILES/tmx               /usr/local/bin/tmx
            ln -s $DOTFILES/.gemrc            $HOME/.gemrc
            ln -s $DOTFILES/.vimrc            $HOME/.vimrc
            ln -s $DOTFILES/.zshrc            $HOME/.zshrc
            ln -s $DOTFILES/.doom.d           $CONFIG_DIR/doom
            ln -s $DOTFILES/starship.toml     $CONFIG_DIR/starship.toml
            ln -s $DOTFILES/.gitconfig_delta  $HOME/.gitconfig_delta
            ln -s $DOTFILES/sheldon           $CONFIG_DIR/sheldon
            ln -s $DOTFILES/sketchybar        $CONFIG_DIR/sketchybar
            ln -s $DOTFILES/skhd              $CONFIG_DIR/skhd
            ln -s $DOTFILES/yabai             $CONFIG_DIR/yabai
            ln -s $DOTFILES/alacritty         $CONFIG_DIR/alacritty
            ln -s $DOTFILES/zellij            $CONFIG_DIR/zellij
      CMD

      title 'Link dotfiles'
      command cmd
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
