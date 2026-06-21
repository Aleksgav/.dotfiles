# frozen_string_literal: true

module Linux
  module Arch
    Mu = Packager::Package::Builder.build do
      title 'Mu'
      command 'yay -S --needed --noconfirm mu'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
