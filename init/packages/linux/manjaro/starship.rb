# frozen_string_literal: true

module Linux
  module Manjaro
    Starship = Packager::Package::Builder.build do
      link = <<~CMD
        export DOTFILES=$HOME/.dotfiles
        export CONFIG_DIR=#{CONFIG_DIR}

        mv -f $CONFIG_DIR/starship.toml{,.bak}
        ln -s $DOTFILES/starship.toml     $CONFIG_DIR/starship.toml
      CMD

      title 'Starship'
      command 'pamac install starship --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install link
    end
  end
end
