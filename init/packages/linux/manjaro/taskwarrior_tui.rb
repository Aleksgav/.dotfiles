# frozen_string_literal: true

module Linux
  module Manjaro
    TaskwarriorTui = Packager::Package::Builder.build do
      title 'Taskwarrior TUI'
      command 'pamac install taskwarrior-tui --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
