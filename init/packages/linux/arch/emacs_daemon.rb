# frozen_string_literal: true

module Linux
  module Arch
    EmacsDaemon = Packager::Package::Builder.build do
      title 'Emacs Daemon'
      command 'systemctl --user enable --now emacs'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
