# frozen_string_literal: true

module Linux
  module Manjaro
    Throne = Packager::Package::Builder.build do
      title 'Throne'
      command 'pamac build throne-bin --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
