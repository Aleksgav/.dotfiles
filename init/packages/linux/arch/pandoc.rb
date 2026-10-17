# frozen_string_literal: true

module Linux
  module Arch
    Pandoc = Packager::Package::Builder.build do
      title 'Pandoc'
      command 'pacman -S --needed --noconfirm pandoc-cli'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
