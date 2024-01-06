# frozen_string_literal: true

module Linux
  module Manjaro
    Zenith = Packager::Package::Builder.build do
      title 'Zenith'
      command 'pamac install zenith --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
