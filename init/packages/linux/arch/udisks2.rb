# frozen_string_literal: true

module Linux
  module Arch
    Udisks2 = Packager::Package::Builder.build do
      title 'udisks2 (storage mount backend)'
      command 'pacman -S --needed --noconfirm udisks2'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
