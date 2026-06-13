# frozen_string_literal: true

module Linux
  module Manjaro
    Polybar = Packager::Package::Builder.build do
      link = <<~CMD
        export DOTFILES=$HOME/.dotfiles
        export CONFIG_DIR=#{CONFIG_DIR}

        ln -s $DOTFILES/polybar           $CONFIG_DIR/polybar
      CMD

      title 'Polybar'
      command 'pamac install polybar --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install link
    end
  end
end
