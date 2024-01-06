# frozen_string_literal: true

module Linux
  module Manjaro
    Grpc = Packager::Package::Builder.build do
      title 'GRPC'
      command 'pamac install grpc --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
