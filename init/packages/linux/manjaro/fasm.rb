# frozen_string_literal: true

module Linux
  module Manjaro
    Fasm = Packager::Package::Builder.build do
      title 'Fasm'
      command 'pamac install fasm --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
