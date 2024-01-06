# frozen_string_literal: true

module Linux
  module Manjaro
    Golang = Packager::Package::Builder.build do
      title 'Golang (pamac)'
      command 'pamac install go --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
