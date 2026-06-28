# frozen_string_literal: true

module Linux
  module Arch
    # On Manjaro each package links its own config in `post_install`. Arch is
    # installed "without packages", so this single package performs all the
    # user-level dotfile linking the per-package steps would otherwise do.
    LinkDotfiles = Packager::Package::Builder.build do
      title 'Link dotfiles'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
      post_install do
        # Home dotfiles
        Linker.link '.vimrc', '~/.vimrc'
        Linker.link 'mise', "#{CONFIG_DIR}/mise"
      end
    end
  end
end
