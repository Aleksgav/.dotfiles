# frozen_string_literal: true

module Linux
  module Arch
    Ghc = Packager::Package::Builder.build do
      title 'GHC (Glasgow Haskell Compiler, ghcup)'
      command 'ghcup install ghc --set'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
