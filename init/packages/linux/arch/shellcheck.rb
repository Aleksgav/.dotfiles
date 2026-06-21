# frozen_string_literal: true

module Linux
  module Arch
    Shellcheck = Packager::Package::Builder.build do
      title 'Shellcheck'
      command 'pacman -S --needed --noconfirm shellcheck'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
