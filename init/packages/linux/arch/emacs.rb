# frozen_string_literal: true

module Linux
  module Arch
    Emacs = Packager::Package::Builder.build do
      title 'Emacs'
      command 'pacman -S --needed --noconfirm emacs'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install 'systemctl --user enable --now emacs'
    end
  end
end
