# frozen_string_literal: true

module Linux
  module Manjaro
    Nnn = Packager::Package::Builder.build do
      title 'Nnn'
      command 'pamac install nnn --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
