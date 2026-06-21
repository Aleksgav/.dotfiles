# frozen_string_literal: true

module Linux
  module Arch
    Opera = Packager::Package::Builder.build do
      title 'Opera'
      command 'yay -S --needed --noconfirm opera'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
