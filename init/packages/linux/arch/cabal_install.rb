# frozen_string_literal: true

module Linux
  module Arch
    CabalInstall = Packager::Package::Builder.build do
      title 'Cabal Install (ghcup)'
      command 'ghcup install cabal --set'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
