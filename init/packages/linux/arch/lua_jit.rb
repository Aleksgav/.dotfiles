# frozen_string_literal: true

module Linux
  module Arch
    LuaJit = Packager::Package::Builder.build do
      title 'LuaJit'
      command 'pacman -S --needed --noconfirm luajit'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
