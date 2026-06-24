# frozen_string_literal: true

module Linux
  module Arch
    Gitleaks = Packager::Package::Builder.build do
      title 'Gitleaks'
      command 'pacman -S --needed --noconfirm gitleaks'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
