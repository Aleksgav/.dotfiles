# frozen_string_literal: true

module Linux
  module Arch
    Python = Packager::Package::Builder.build do
      title 'Python'
      command 'pacman -S --needed --noconfirm python'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
