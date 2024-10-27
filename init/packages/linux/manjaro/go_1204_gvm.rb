# frozen_string_literal: true

module Linux
  module Manjaro
    Go1204Gvm = Packager::Package::Builder.build do
      title 'Golang 1.20.4 (GVM)'
      command 'source "$HOME/.gvm/scripts/gvm" && gvm install go1.20.4'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
