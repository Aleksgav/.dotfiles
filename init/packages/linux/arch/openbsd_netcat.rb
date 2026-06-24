# frozen_string_literal: true

module Linux
  module Arch
    OpenbsdNetcat = Packager::Package::Builder.build do
      title 'OpenBSD netcat'
      command 'pacman -S --needed --noconfirm openbsd-netcat'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
