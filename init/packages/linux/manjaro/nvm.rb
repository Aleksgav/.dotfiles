# frozen_string_literal: true

module Linux
  module Manjaro
    Nvm = Packager::Package::Builder.build do
      title 'NVM'
      command 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
