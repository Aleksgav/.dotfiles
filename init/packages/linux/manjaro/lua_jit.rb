# frozen_string_literal: true

module Linux
  module Manjaro
    LuaJit = Packager::Package::Builder.build do
      title 'LuaJit'
      command 'pamac install luajit --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
