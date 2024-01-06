# frozen_string_literal: true

module Linux
  module Manjaro
    Protobuf = Packager::Package::Builder.build do
      title 'Protobuf'
      command 'pamac install protobuf --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
