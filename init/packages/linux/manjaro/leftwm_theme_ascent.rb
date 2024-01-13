# frozen_string_literal: true

module Linux
  module Manjaro
    LeftwmThemeAscent = Packager::Package::Builder.build do
      cmd =<<-CMD
        leftwm-theme update
        leftwm-theme install Ascent
        leftwm-theme apply Ascent
      CMD

      title 'Leftwm-theme Ascent'
      command cmd
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
