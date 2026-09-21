# frozen_string_literal: true

module Linux
  module Arch
    Quickshell = Packager::Package::Builder.build do
      title 'Quickshell'
      command 'pacman -S --needed --noconfirm quickshell'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install { Linker.link 'quickshell', "#{CONFIG_DIR}/quickshell" }
    end
  end
end
