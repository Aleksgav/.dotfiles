# frozen_string_literal: true

module Linux
  module Manjaro
    Kmon = Packager::Package::Builder.build do
      title 'Kmon'
      command 'pamac install kmon --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
