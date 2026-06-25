# frozen_string_literal: true

module Linux
  module Arch
    Wlogout = Packager::Package::Builder.build do
      title 'Wlogout'
      command 'yay -S --needed --noconfirm wlogout'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
