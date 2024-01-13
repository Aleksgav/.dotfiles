# frozen_string_literal: true

module Linux
  module Manjaro
    Slock = Packager::Package::Builder.build do
      title 'Slock'
      command 'pamac install slock --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
