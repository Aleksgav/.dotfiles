# frozen_string_literal: true

module Linux
  module Manjaro
    GitDelta = Packager::Package::Builder.build do
      link = <<~CMD
        export DOTFILES=$HOME/.dotfiles

        mv -f $HOME/.gitconfig_delta{,.bak}
        ln -s $DOTFILES/.gitconfig_delta  $HOME/.gitconfig_delta
      CMD

      title 'Git delta'
      command 'pamac install git-delta --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install link
    end
  end
end
