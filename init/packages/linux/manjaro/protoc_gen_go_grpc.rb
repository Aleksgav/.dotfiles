# frozen_string_literal: true

module Linux
  module Manjaro
    ProtocGenGoGrpc = Packager::Package::Builder.build do
      title 'Protoc gen go GRPC'
      command 'go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
