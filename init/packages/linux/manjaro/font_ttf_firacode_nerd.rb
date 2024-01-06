# frozen_string_literal: true

module Linux
  module Manjaro
    FontTtfFiracodeNerd = Packager::Package::Builder.build do
      title 'Font TTF Firacode Nerd'
      command 'pamac install ttf-firacode-nerd --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
