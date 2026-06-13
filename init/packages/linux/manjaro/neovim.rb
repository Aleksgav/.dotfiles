# frozen_string_literal: true

module Linux
  module Manjaro
    Neovim = Packager::Package::Builder.build do
      link = <<~CMD
        export DOTFILES=$HOME/.dotfiles
        export CONFIG_DIR=#{CONFIG_DIR}

        mv -f $CONFIG_DIR/nvim{,.bak}
        mv ~/.local/share/nvim{,.bak}
        mv ~/.local/state/nvim{,.bak}
        mv ~/.cache/nvim{,.bak}

        ln -s $DOTFILES/nvim-ng ~/.config/nvim-ng
        ln -s $DOTFILES/nvim ~/.config/nvim
      CMD

      title 'Neovim'
      command 'pamac install neovim --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install link
    end
  end
end
