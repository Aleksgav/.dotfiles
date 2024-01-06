# frozen_string_literal: true

module Linux
  module Manjaro
    FlatpakPlugin = Packager::Package::Builder.build do
      title 'Flatpak plugin'
      command 'pamac install libpamac-flatpak-plugin'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
