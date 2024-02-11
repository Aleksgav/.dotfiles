# frozen_string_literal: true

module Linux
  module Manjaro
    OutlineClientCli = Packager::Package::Builder.build do
      title 'Outline Client CLI'
      command 'go install github.com/Jigsaw-Code/outline-sdk/x/examples/outline-cli@latest'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
