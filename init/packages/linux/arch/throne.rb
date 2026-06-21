# frozen_string_literal: true

module Linux
  module Arch
    Throne = Packager::Package::Builder.build do
      title 'Throne'
      command 'yay -S --needed --noconfirm throne-bin'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
