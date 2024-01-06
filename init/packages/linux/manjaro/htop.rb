# frozen_string_literal: true

module Linux
  module Manjaro
    Htop = Packager::Package::Builder.build do
      title 'Htop'
      command 'pamac install htop --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
