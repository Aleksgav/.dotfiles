# frozen_string_literal: true

module Linux
  module Manjaro
    LuaRocks = Packager::Package::Builder.build do
      title 'LuaRocks'
      command 'pamac install luarocks --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
