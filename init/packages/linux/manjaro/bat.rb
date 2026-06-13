# frozen_string_literal: true

module Linux
  module Manjaro
    Bat = Packager::Package::Builder.build do
      link = <<~CMD
        export DOTFILES=$HOME/.dotfiles
        export CONFIG_DIR=#{CONFIG_DIR}

        ln -s $DOTFILES/bat               $CONFIG_DIR/bat
      CMD

      title 'Bat'
      command 'pamac install bat --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install link
    end
  end
end
