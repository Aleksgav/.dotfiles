# frozen_string_literal: true

module Linux
  module Manjaro
    Superfile = Packager::Package::Builder.build do
      title 'Superfile'
      command 'pamac install superfile --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
