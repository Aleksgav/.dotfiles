# frozen_string_literal: true

module Linux
  module Manjaro
     ReloadCargo = Packager::Package::Builder.build do
      title 'Cargo Reload'
      command '. "$HOME/.cargo/env"'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
