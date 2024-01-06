# frozen_string_literal: true

module Linux
  module Manjaro
    Neovim = Packager::Package::Builder.build do
      title 'Neovim'
      command 'pamac install neovim --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
