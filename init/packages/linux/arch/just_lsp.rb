# frozen_string_literal: true

module Linux
  module Arch
    JustLsp = Packager::Package::Builder.build do
      title 'Just lsp'
      command 'pacman -S --needed --noconfirm just-lsp'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
