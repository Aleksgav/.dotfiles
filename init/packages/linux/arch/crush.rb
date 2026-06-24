# frozen_string_literal: true

module Linux
  module Arch
    Crush = Packager::Package::Builder.build do
      title 'Crush'
      command 'yay -S --needed --noconfirm crush-bin'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
