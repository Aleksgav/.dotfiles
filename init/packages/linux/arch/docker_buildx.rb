# frozen_string_literal: true

module Linux
  module Arch
    DockerBuildx = Packager::Package::Builder.build do
      title 'Docker Buildx'
      command 'pacman -S --needed --noconfirm docker-buildx'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
