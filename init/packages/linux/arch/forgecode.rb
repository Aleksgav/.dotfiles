# frozen_string_literal: true

module Linux
  module Arch
    Forgecode = Packager::Package::Builder.build do
      title 'Forgecode'
      # Forge's native installer
      command 'curl -fsSL https://forgecode.dev/cli | sh'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
      # Forge's zsh integration
      post_install 'forge zsh setup'
    end
  end
end
