# frozen_string_literal: true

module Linux
  module Arch
    Forgecode = Packager::Package::Builder.build do
      title 'Forgecode'
      command 'yay -S --needed --noconfirm forgecode'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
      # Forge's zsh integration
      post_install 'forge zsh setup'
    end
  end
end
