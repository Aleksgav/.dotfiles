# frozen_string_literal: true

module Linux
  module Manjaro
    Xplr = Packager::Package::Builder.build do
      title 'Xplr'
      command 'pamac install xplr --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
