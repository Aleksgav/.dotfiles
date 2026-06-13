# frozen_string_literal: true

module Linux
  module Manjaro
    Glow = Packager::Package::Builder.build do
      link = <<~CMD
        export DOTFILES=$HOME/.dotfiles
        export CONFIG_DIR=#{CONFIG_DIR}

        mv -f $CONFIG_DIR/glow{,.bak}
        ln -s $DOTFILES/glow              $CONFIG_DIR/glow
      CMD

      title 'Glow'
      command 'pamac install glow --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install link
    end
  end
end
