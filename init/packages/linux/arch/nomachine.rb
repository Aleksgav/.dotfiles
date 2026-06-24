# frozen_string_literal: true

module Linux
  module Arch
    Nomachine = Packager::Package::Builder.build do
      title 'NoMachine'
      command 'yay -S --needed --noconfirm nomachine'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
