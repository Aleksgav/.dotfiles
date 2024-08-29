# frozen_string_literal: true

module Linux
  module Manjaro
    Zoxide = Packager::Package::Builder.build do
      title 'Zoxide'
      command 'pamac install zoxide --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
