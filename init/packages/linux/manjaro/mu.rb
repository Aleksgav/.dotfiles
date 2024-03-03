# frozen_string_literal: true

module Linux
  module Manjaro
    Mu = Packager::Package::Builder.build do
      title 'Mu'
      command 'pamac build mu --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
