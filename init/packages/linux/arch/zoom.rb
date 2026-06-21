# frozen_string_literal: true

module Linux
  module Arch
    Zoom = Packager::Package::Builder.build do
      title 'Zoom'
      command 'yay -S --needed --noconfirm zoom'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
