# frozen_string_literal: true

module Linux
  module Manjaro
    Go123Gvm = Packager::Package::Builder.build do
      title 'Golang 1.23 (GVM)'
      command 'source "$HOME/.gvm/scripts/gvm" && gvm install go1.23'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
