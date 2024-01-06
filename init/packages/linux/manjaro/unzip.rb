# frozen_string_literal: true

module Linux
  module Manjaro
    Unzip = Packager::Package::Builder.build do
      title 'Unzip'
      command 'pamac install unzip --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
