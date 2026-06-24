# frozen_string_literal: true

module Linux
  module Arch
    Vagrant = Packager::Package::Builder.build do
      title 'Vagrant'
      command 'yay -S --needed --noconfirm vagrant'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
