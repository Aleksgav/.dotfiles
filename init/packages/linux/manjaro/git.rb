# frozen_string_literal: true

module Linux
  module Manjaro
    Git = Packager::Package::Builder.build do
      link = <<~CMD
        export DOTFILES=$HOME/.dotfiles

        mv -f $HOME/.gitignore-system{,.bak}
        ln -s $DOTFILES/.gitignore-system $HOME/.gitignore-system

        mv -f $HOME/.gitconfig{,.bak}
        ln -s $DOTFILES/.gitconfig        $HOME/.gitconfig
      CMD

      title 'GIT'
      command 'pamac install git --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install link
    end
  end
end
