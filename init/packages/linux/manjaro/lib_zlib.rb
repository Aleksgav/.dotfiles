# frozen_string_literal: true

module Linux
  module Manjaro
    LibZlib = Packager::Package::Builder.build do
      title 'Zlib'
      command 'pamac install zlib --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
