# frozen_string_literal: true

module Linux
  module Arch
    Golangcilint = Packager::Package::Builder.build do
      title 'Golangci lint '
      command 'go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
