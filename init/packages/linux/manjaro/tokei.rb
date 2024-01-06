# frozen_string_literal: true

module Linux
  module Manjaro
    Tokei = Packager::Package::Builder.build do
      title 'Tokei'
      command 'pamac install tokei --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
