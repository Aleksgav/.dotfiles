# frozen_string_literal: true

module Linux
  module Arch
    CupsFilters = Packager::Package::Builder.build do
      title 'CUPS filters'
      command 'pacman -S --needed --noconfirm cups-filters'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
