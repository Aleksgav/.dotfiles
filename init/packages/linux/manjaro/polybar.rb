# frozen_string_literal: true

module Linux
  module Manjaro
    Polybar = Packager::Package::Builder.build do
      title 'Polybar'
      command 'pamac install polybar --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
