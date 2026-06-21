# frozen_string_literal: true

module Linux
  module Arch
    DockerCompose = Packager::Package::Builder.build do
      title 'Docker compose'
      command 'pacman -S --needed --noconfirm docker-compose'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
