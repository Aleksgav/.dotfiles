# frozen_string_literal: true

module Linux
  module Manjaro
    GolangcilintSnap = Packager::Package::Builder.build do
      title 'Golangci lint '
      command 'snap install golangci-lint'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
