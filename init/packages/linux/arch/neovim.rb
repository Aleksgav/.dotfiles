# frozen_string_literal: true

module Linux
  module Arch
    Neovim = Packager::Package::Builder.build do
      title 'Neovim'
      command 'pacman -S --needed --noconfirm neovim'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install do
        Linker.backup '~/.local/share/nvim'
        Linker.backup '~/.local/state/nvim'
        Linker.backup '~/.cache/nvim'
        Linker.link 'nvim', "#{CONFIG_DIR}/nvim"
      end
    end
  end
end
