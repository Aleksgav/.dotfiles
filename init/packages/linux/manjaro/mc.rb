# frozen_string_literal: true

module Linux
  module Manjaro
    Mc = Packager::Package::Builder.build do
      title 'Midnight commander'
      command 'pamac install mc --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
