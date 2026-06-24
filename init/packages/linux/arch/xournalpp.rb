# frozen_string_literal: true

module Linux
  module Arch
    Xournalpp = Packager::Package::Builder.build do
      title 'Xournal++'
      command 'pacman -S --needed --noconfirm xournalpp'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
