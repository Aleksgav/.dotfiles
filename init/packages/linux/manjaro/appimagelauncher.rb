# frozen_string_literal: true

module Linux
  module Manjaro
    Appimagelauncher = Packager::Package::Builder.build do
      title 'Appimagelauncher'
      command 'pamac build appimagelauncher --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
