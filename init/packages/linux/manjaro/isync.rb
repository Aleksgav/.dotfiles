# frozen_string_literal: true

module Linux
  module Manjaro
    Isync = Packager::Package::Builder.build do
      link = <<~CMD
        export DOTFILES=$HOME/.dotfiles

        ln -s $DOTFILES/.mbsyncrc ~/.mbsyncrc
        mkdir ~/Mail
      CMD

      title 'Isync'
      command 'pamac install isync --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install link
    end
  end
end
