# frozen_string_literal: true

module Linux
  module Manjaro
    VirtualboxGuestUtils = Packager::Package::Builder.build do
      title 'Virtualbox Guest Utils'
      command 'pamac install virtualbox-guest-utils --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
