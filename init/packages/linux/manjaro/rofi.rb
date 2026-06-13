# frozen_string_literal: true

module Linux
  module Manjaro
    Rofi = Packager::Package::Builder.build do
      link = <<~CMD
        export DOTFILES=$HOME/.dotfiles
        export CONFIG_DIR=#{CONFIG_DIR}

        ln -s $DOTFILES/rofi              $CONFIG_DIR/rofi
      CMD

      title 'Rofi'
      command 'pamac install rofi --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install link
    end
  end
end
