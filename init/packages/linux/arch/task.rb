# frozen_string_literal: true

module Linux
  module Arch
    Task = Packager::Package::Builder.build do
      title 'Task'
      command 'pacman -S --needed --noconfirm task'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
