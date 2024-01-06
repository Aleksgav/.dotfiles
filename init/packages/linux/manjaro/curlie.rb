# frozen_string_literal: true

module Linux
  module Manjaro
    Curlie = Packager::Package::Builder.build do
      title 'Curlie'
      command 'pamac install curlie --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
