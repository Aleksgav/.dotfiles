# frozen_string_literal: true

module Linux
  module Manjaro
    DockerCompose = Packager::Package::Builder.build do
      title 'Docker compose'
      command 'pamac install docker-compose --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
