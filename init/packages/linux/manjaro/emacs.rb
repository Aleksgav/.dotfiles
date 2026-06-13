# frozen_string_literal: true

module Linux
  module Manjaro
    Emacs = Packager::Package::Builder.build do
      link = <<~CMD
        export DOTFILES=$HOME/.dotfiles
        export CONFIG_DIR=#{CONFIG_DIR}

        mv -f $CONFIG_DIR/doom{,.bak}
        ln -s $DOTFILES/.doom.d           $CONFIG_DIR/doom
      CMD

      title 'Emacs'
      command 'pamac install emacs --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install link
    end
  end
end
