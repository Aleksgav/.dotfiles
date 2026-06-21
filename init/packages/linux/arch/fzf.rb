# frozen_string_literal: true

module Linux
  module Arch
    Fzf = Packager::Package::Builder.build do
      title 'Fzf'
      command 'pacman -S --needed --noconfirm fzf'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
