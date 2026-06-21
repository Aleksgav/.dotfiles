# frozen_string_literal: true

module Linux
  module Arch
    HaskellLanguageServer = Packager::Package::Builder.build do
      title 'Haskell Language Server (ghcup)'
      command 'ghcup install hls --set'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
