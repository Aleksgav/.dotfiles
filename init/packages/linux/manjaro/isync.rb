# frozen_string_literal: true

module Linux
  module Manjaro
    Isync = Packager::Package::Builder.build do
      title 'isync'
      command 'pamac install isync --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
