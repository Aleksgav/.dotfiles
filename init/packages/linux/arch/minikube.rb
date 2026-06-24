# frozen_string_literal: true

module Linux
  module Arch
    Minikube = Packager::Package::Builder.build do
      title 'Minikube'
      command 'pacman -S --needed --noconfirm minikube'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
