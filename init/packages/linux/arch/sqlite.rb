# frozen_string_literal: true

module Linux
  module Arch
    Sqlite = Packager::Package::Builder.build do
      title 'SQLite'
      command 'pacman -S --needed --noconfirm sqlite'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
