# frozen_string_literal: true

module Linux
  module Arch
    Ghcup = Packager::Package::Builder.build do
      title 'GHCup (mise)'
      command 'mise install ghcup'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
