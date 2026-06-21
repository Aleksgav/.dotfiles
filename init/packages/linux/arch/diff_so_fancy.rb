# frozen_string_literal: true

module Linux
  module Arch
    DiffSoFancy = Packager::Package::Builder.build do
      title 'Diff so fancy'
      command 'pacman -S --needed --noconfirm diff-so-fancy'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
