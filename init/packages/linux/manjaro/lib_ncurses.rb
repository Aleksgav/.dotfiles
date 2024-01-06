# frozen_string_literal: true

module Linux
  module Manjaro
    LibNcurses = Packager::Package::Builder.build do
      title 'Ncurses'
      command 'pamac install ncurses --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
