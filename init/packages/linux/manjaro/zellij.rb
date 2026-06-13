# frozen_string_literal: true

module Linux
  module Manjaro
    Zellij = Packager::Package::Builder.build do
      link = <<~CMD
        export DOTFILES=$HOME/.dotfiles
        export CONFIG_DIR=#{CONFIG_DIR}

        mv -f $CONFIG_DIR/zellij{,.bak}
        ln -s $DOTFILES/zellij            $CONFIG_DIR/zellij
      CMD

      title 'Zellij'
      command 'pamac install zellij --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install link
    end
  end
end
