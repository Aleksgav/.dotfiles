# frozen_string_literal: true

module Linux
  module Manjaro
    GpgTui = Packager::Package::Builder.build do
      title 'Gpg Tui'
      command 'pamac install gpg-tui --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
