# frozen_string_literal: true

module Linux
  module Manjaro
    Nodejs20Nvm = Packager::Package::Builder.build do
      title 'Nodejs'
      command '. $HOME/.config/.nvm/nvm.sh && nvm install 20 && nvm use 20'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
