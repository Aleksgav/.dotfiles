# frozen_string_literal: true

module Linux
  module Manjaro
    FontTtfNerdSymbolsMono = Packager::Package::Builder.build do
      title 'Font TTF Nerd Symbols Mono'
      command 'pamac install ttf-nerd-fonts-symbols-mono --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
