# frozen_string_literal: true

module Linux
  module Manjaro
    Go1204GvmDefault = Packager::Package::Builder.build do
      title 'Set Golang 1.20.4 as default (GVM)'
      command 'gvm use go1.20.4 --default'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
