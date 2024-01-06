# frozen_string_literal: true

module Linux
  module Manjaro
    Tarantool = Packager::Package::Builder.build do
      title 'Tarantool'
      command 'pamac install tarantool --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
