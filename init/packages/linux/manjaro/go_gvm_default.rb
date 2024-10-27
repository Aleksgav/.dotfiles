# frozen_string_literal: true

module Linux
  module Manjaro
    GoGvmDefault = Packager::Package::Builder.build do
      title 'Set Golang 1.23 as default (GVM)'
      command 'source "$HOME/.gvm/scripts/gvm" && gvm use go1.23 --default'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
