# frozen_string_literal: true

module Linux
  module Arch
    Ansible = Packager::Package::Builder.build do
      title 'Ansible'
      command 'pacman -S --needed --noconfirm ansible'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
