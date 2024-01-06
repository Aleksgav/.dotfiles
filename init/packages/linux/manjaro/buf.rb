# frozen_string_literal: true

module Linux
  module Manjaro
    Buf = Packager::Package::Builder.build do
      title 'Buf'
      command 'pamac install buf --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
