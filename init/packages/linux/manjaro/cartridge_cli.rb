# frozen_string_literal: true

module Linux
  module Manjaro
    CartridgeCli = Packager::Package::Builder.build do
      title 'Cartridge CLI'
      command 'pamac install cartridge-cli --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
