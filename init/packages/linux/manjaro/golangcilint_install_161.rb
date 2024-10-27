# frozen_string_literal: true

module Linux
  module Manjaro
    GolangcilintInstall161 = Packager::Package::Builder.build do
      title 'Golangci lint '
      command 'source "$HOME/.gvm/scripts/gvm" && go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.61.0'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
