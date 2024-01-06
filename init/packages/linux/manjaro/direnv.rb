# frozen_string_literal: true

module Linux
  module Manjaro
    Direnv = Packager::Package::Builder.build do
      title 'Direnv'
      command 'pamac install direnv --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
