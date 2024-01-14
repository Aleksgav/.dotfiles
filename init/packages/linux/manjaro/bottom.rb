# frozen_string_literal: true

module Linux
  module Manjaro
    Bottom = Packager::Package::Builder.build do
      title 'Bottom'
      command 'pamac install bottom --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
