# frozen_string_literal: true

module Linux
  module Manjaro
    Btop = Packager::Package::Builder.build do
      title 'Btop'
      command 'pamac install btop --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
