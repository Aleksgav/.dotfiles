# frozen_string_literal: true

module Linux
  module Manjaro
    EmacsDaemon = Packager::Package::Builder.build do
      title 'Emacs Daemon'
      command 'systemctl --user enable --now emacs'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
