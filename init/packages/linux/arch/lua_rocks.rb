# frozen_string_literal: true

module Linux
  module Arch
    LuaRocks = Packager::Package::Builder.build do
      title 'LuaRocks'
      command 'pacman -S --needed --noconfirm luarocks'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
