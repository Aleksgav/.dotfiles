# frozen_string_literal: true

module Linux
  module Arch
    Yq = Packager::Package::Builder.build do
      title 'yq'
      command 'pacman -S --needed --noconfirm go-yq'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
