# frozen_string_literal: true

module Linux
  module Arch
    LibJemalloc = Packager::Package::Builder.build do
      title 'Jemalloc'
      command 'pacman -S --needed --noconfirm jemalloc'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
