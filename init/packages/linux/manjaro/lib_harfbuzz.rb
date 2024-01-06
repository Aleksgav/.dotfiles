# frozen_string_literal: true

module Linux
  module Manjaro
    LibHarfbuzz = Packager::Package::Builder.build do
      title 'Harfbuzz'
      command 'pamac install harfbuzz --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
