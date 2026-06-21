# frozen_string_literal: true

module Linux
  module Arch
    ZshSyntaxHighliting = Packager::Package::Builder.build do
      title 'Zsh syntax highliting'
      command 'pacman -S --needed --noconfirm zsh-syntax-highlighting'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
