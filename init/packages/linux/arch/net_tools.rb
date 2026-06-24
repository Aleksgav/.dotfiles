# frozen_string_literal: true

module Linux
  module Arch
    NetTools = Packager::Package::Builder.build do
      title 'net-tools'
      command 'pacman -S --needed --noconfirm net-tools'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
