# frozen_string_literal: true

module Linux
  module Manjaro
    XssLock = Packager::Package::Builder.build do
      title 'Xss-lock'
      command 'pamac install xss-lock --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
