# frozen_string_literal: true

module Linux
  module Arch
    FontTtfNerdSymbolsMono = Packager::Package::Builder.build do
      title 'Font TTF Nerd Symbols Mono'
      command 'pacman -S --needed --noconfirm ttf-nerd-fonts-symbols-mono'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
