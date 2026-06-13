# frozen_string_literal: true

module Linux
  module Manjaro
    Conky = Packager::Package::Builder.build do
      link = <<~CMD
        export DOTFILES=$HOME/.dotfiles
        export CONFIG_DIR=#{CONFIG_DIR}

        ln -s $DOTFILES/autostart/conky.desktop $CONFIG_DIR/autostart/conky.desktop
        ln -s $DOTFILES/conky             $CONFIG_DIR/conky
      CMD

      title 'Conky'
      command 'pamac install conky --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install link
    end
  end
end
