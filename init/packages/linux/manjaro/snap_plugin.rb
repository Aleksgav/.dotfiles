# frozen_string_literal: true

module Linux
  module Manjaro
    SnapPlugin = Packager::Package::Builder.build do
      title 'Snap plugin'
      command 'pamac install libpamac-snap-plugin'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
