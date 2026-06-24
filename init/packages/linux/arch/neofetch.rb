# frozen_string_literal: true

module Linux
  module Arch
    Neofetch = Packager::Package::Builder.build do
      title 'Neofetch'
      command 'yay -S --needed --noconfirm neofetch'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
