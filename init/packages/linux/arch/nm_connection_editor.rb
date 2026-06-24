# frozen_string_literal: true

module Linux
  module Arch
    NmConnectionEditor = Packager::Package::Builder.build do
      title 'NM connection editor'
      command 'pacman -S --needed --noconfirm nm-connection-editor'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
