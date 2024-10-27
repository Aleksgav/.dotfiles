# frozen_string_literal: true

module Linux
  module Manjaro
    Yarn = Packager::Package::Builder.build do
      title 'Yarn'
      command '. $HOME/.config/nvm/nvm.sh && npm install --global yarn'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
