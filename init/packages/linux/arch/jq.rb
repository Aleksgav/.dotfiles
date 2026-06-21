# frozen_string_literal: true

module Linux
  module Arch
    Jq = Packager::Package::Builder.build do
      title 'Jq'
      command 'pacman -S --needed --noconfirm jq'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
