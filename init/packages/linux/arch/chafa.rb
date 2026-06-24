# frozen_string_literal: true

module Linux
  module Arch
    Chafa = Packager::Package::Builder.build do
      title 'Chafa'
      command 'pacman -S --needed --noconfirm chafa'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
