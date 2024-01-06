# frozen_string_literal: true

module Linux
  module Manjaro
    LibCairo = Packager::Package::Builder.build do
      title 'Cairo'
      command 'pamac install cairo --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
