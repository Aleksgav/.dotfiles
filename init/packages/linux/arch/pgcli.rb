# frozen_string_literal: true

module Linux
  module Arch
    Pgcli = Packager::Package::Builder.build do
      title 'pgcli'
      command 'pacman -S --needed --noconfirm pgcli'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
