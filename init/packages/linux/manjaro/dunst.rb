# frozen_string_literal: true

module Linux
  module Manjaro
    Dunst = Packager::Package::Builder.build do
      link = <<~CMD
        export DOTFILES=$HOME/.dotfiles
        export CONFIG_DIR=#{CONFIG_DIR}

        ln -s $DOTFILES/dunst             $CONFIG_DIR/dunst
      CMD

      title 'Dunst'
      command 'pamac install dunst --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install link
    end
  end
end
