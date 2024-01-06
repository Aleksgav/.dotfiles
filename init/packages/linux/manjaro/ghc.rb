# frozen_string_literal: true

module Linux
  module Manjaro
    Ghc = Packager::Package::Builder.build do
      title 'GHC (Glazgo Haskell Compiler)'
      command 'pamac install ghc --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
