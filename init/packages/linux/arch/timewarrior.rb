# frozen_string_literal: true

module Linux
  module Arch
    Timewarrior = Packager::Package::Builder.build do
      title 'Timewarrior'
      command 'pacman -S --needed --noconfirm timew'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
