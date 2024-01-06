# frozen_string_literal: true

module Linux
  module Manjaro
    Virtualbox = Packager::Package::Builder.build do
      title 'Virtualbox'
      command 'pamac install virtualbox --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
