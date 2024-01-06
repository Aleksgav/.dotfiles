# frozen_string_literal: true

module Linux
  module Manjaro
    Lua = Packager::Package::Builder.build do
      title 'Lua'
      command 'pamac install lua --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
