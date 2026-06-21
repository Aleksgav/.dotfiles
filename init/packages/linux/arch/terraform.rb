# frozen_string_literal: true

module Linux
  module Arch
    Terraform = Packager::Package::Builder.build do
      title 'Terraform'
      command 'pacman -S --needed --noconfirm terraform'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
