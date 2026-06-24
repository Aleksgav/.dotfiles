# frozen_string_literal: true

module Linux
  module Arch
    Mesa = Packager::Package::Builder.build do
      title 'Mesa'
      command 'pacman -S --needed --noconfirm mesa'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
