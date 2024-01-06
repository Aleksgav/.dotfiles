# frozen_string_literal: true

module Linux
  module Manjaro
    Wget = Packager::Package::Builder.build do
      title 'Wget'
      command 'pamac install wget --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
