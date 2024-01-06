# frozen_string_literal: true

module Linux
  module Manjaro
    LibPango = Packager::Package::Builder.build do
      title 'Pango'
      command 'pamac install pango --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
