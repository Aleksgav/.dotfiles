# frozen_string_literal: true

module Linux
  module Manjaro
    LibReadline = Packager::Package::Builder.build do
      title 'Readline'
      command 'pamac install readline --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
