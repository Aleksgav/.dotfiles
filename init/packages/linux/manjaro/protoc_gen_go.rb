# frozen_string_literal: true

module Linux
  module Manjaro
    ProtocGenGo = Packager::Package::Builder.build do
      title 'Protoc gen go'
      command 'go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
