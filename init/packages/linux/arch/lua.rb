# frozen_string_literal: true

module Linux
  module Arch
    Lua = Packager::Package::Builder.build do
      title 'Lua'
      command 'pacman -S --needed --noconfirm lua'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
