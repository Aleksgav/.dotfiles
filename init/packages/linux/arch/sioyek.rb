# frozen_string_literal: true

module Linux
  module Arch
    Sioyek = Packager::Package::Builder.build do
      title 'Sioyek'
      command 'yay -S --needed --noconfirm sioyek'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
