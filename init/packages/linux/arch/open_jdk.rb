# frozen_string_literal: true

module Linux
  module Arch
    OpenJdk = Packager::Package::Builder.build do
      title 'Open JDK'
      command 'pacman -S --needed --noconfirm jdk-openjdk'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
