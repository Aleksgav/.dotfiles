# frozen_string_literal: true

module Linux
  module Arch
    Age = Packager::Package::Builder.build do
      title 'Age'
      command 'pacman -S --needed --noconfirm age'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
