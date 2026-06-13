# frozen_string_literal: true

module Linux
  module Manjaro
    Sheldon = Packager::Package::Builder.build do
      link = <<~CMD
        export DOTFILES=$HOME/.dotfiles
        export CONFIG_DIR=#{CONFIG_DIR}

        mv -f $CONFIG_DIR/sheldon{,.bak}
        ln -s $DOTFILES/sheldon           $CONFIG_DIR/sheldon
      CMD

      title 'Sheldon'
      command 'pamac install sheldon --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install link
    end
  end
end
