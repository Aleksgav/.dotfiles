# frozen_string_literal: true

module Linux
  module Arch
    CupsPdf = Packager::Package::Builder.build do
      title 'CUPS PDF'
      command 'pacman -S --needed --noconfirm cups-pdf'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
