# frozen_string_literal: true

module Linux
  module Manjaro
    LinkDotfiles = Packager::Package::Builder.build do
      title 'Global links'
      command 'cp -f $HOME/.dotfiles/xorg.conf.d/00-keyboard.conf /etc/X11/xorg.conf.d/'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install do
        Linker.link '.vimrc', '~/.vimrc'
        Linker.mkdir '~/.ssh'
        Linker.link 'mise', "#{CONFIG_DIR}/mise"
        Linker.link '.Xresources', '~/.Xresources'
      end
    end
  end
end
