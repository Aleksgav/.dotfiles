# frozen_string_literal: true

module Linux
  module Arch
    CommonLisp = Packager::Package::Builder.build do
      title 'CommonLisp'
      command 'pacman -S --needed --noconfirm sbcl'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
