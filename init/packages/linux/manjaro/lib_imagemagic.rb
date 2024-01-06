# frozen_string_literal: true

module Linux
  module Manjaro
    LibImagemagic = Packager::Package::Builder.build do
      title 'Imagemagic'
      command 'pamac install imagemagick --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
