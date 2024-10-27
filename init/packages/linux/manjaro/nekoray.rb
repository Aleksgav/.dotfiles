# frozen_string_literal: true

module Linux
  module Manjaro
    Nekoray = Packager::Package::Builder.build do
      title 'Nekoray'
      command 'pamac build nekoray-bin --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
