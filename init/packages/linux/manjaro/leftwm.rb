# frozen_string_literal: true

module Linux
  module Manjaro
    Leftwm = Packager::Package::Builder.build do
      title 'Leftwm window manager'
      command 'cargo install leftwm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
      post_install { Linker.link 'leftwm', "#{CONFIG_DIR}/leftwm" }
      post_install 'ln -s $HOME/.dotfiles/leftwm/leftwm.desktop /usr/share/xsessions', sudo: true
    end
  end
end
