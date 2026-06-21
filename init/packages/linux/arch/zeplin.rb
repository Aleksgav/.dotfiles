# frozen_string_literal: true

module Linux
  module Arch
    Zeplin = Packager::Package::Builder.build do
      title 'Zeplin'
      command 'yay -S --needed --noconfirm zeplin'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
