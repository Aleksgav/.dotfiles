# frozen_string_literal: true

module Linux
  module Manjaro
    CabalInstall = Packager::Package::Builder.build do
      title 'Cabal Install'
      command 'pamac install cabal-install --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
