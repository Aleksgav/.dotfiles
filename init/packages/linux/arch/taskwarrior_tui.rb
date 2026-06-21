# frozen_string_literal: true

module Linux
  module Arch
    TaskwarriorTui = Packager::Package::Builder.build do
      title 'Taskwarrior TUI'
      command 'pacman -S --needed --noconfirm taskwarrior-tui'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
