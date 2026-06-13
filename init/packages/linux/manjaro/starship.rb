# frozen_string_literal: true

module Linux
  module Manjaro
    Starship = Packager::Package::Builder.build do
      title 'Starship'
      command 'pamac install starship --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install { Linker.link 'starship.toml', "#{CONFIG_DIR}/starship.toml" }
    end
  end
end
