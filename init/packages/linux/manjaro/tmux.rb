# frozen_string_literal: true

module Linux
  module Manjaro
    Tmux = Packager::Package::Builder.build do
      title 'Tmux'
      command 'pamac install tmux --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install do
        Linker.link '.tmux.conf', '~/.tmux.conf'
        Linker.link '.tmux.linux.conf', '~/.tmux.linux.conf'
      end
      # tmx wrapper lives in a root owned dir
      post_install 'mv -f /usr/local/bin/tmx{,.bak}; ln -s $HOME/.dotfiles/tmx /usr/local/bin/tmx', sudo: true
    end
  end
end
