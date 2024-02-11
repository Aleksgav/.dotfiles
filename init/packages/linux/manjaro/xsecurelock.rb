# frozen_string_literal: true

module Linux
  module Manjaro
    Xsecurelock = Packager::Package::Builder.build do
      title 'Xsecurelock'
      command 'pamac install xsecurelock --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
