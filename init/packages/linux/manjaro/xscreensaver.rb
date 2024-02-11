# frozen_string_literal: true

module Linux
  module Manjaro
    Xscreensaver = Packager::Package::Builder.build do
      title 'Xscreensaver'
      command 'pamac install xscreensaver --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
