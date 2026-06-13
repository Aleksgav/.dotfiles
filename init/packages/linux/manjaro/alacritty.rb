# frozen_string_literal: true

module Linux
  module Manjaro
    Alacritty = Packager::Package::Builder.build do
      link = <<~CMD
        export DOTFILES=$HOME/.dotfiles
        export CONFIG_DIR=#{CONFIG_DIR}

        mv -f $CONFIG_DIR/alacritty{,.bak}
        ln -s $DOTFILES/alacritty         $CONFIG_DIR/alacritty
      CMD

      title 'Alacritty'
      command 'pamac install alacritty --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install link
    end
  end
end
