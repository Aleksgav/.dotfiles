# frozen_string_literal: true

module Linux
  module Arch
    Uwsm = Packager::Package::Builder.build do
      title 'UWSM (Universal Wayland Session Manager)'
      command 'pacman -S --needed --noconfirm uwsm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install { Linker.link 'uwsm', "#{CONFIG_DIR}/uwsm" }
    end
  end
end
