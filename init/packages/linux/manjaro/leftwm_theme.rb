# frozen_string_literal: true

module Linux
  module Manjaro
    LeftwmTheme = Packager::Package::Builder.build do
      title 'Leftwm-theme'
      command 'cargo install leftwm-theme'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
