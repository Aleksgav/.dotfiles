# frozen_string_literal: true

module Linux
  module Manjaro
    Zsh = Packager::Package::Builder.build do
      link = <<~CMD
        export DOTFILES=$HOME/.dotfiles

        mv -f $HOME/.zshrc{,.bak}
        ln -s $DOTFILES/.zshrc            $HOME/.zshrc
      CMD

      title 'Zsh'
      command 'pamac install zsh --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install link
    end
  end
end
