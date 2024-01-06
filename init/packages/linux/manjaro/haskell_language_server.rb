# frozen_string_literal: true

module Linux
  module Manjaro
    HaskellLanguageServer = Packager::Package::Builder.build do
      title 'Haskell Language Server'
      command 'pamac install haskell-language-server --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
