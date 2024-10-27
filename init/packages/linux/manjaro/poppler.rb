# frozen_string_literal: true

module Linux
  module Manjaro
    Poppler = Packager::Package::Builder.build do
      title 'Poppler'
      command 'pamac install poppler --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
