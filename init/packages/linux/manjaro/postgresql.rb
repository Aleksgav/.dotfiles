# frozen_string_literal: true

module Linux
  module Manjaro
    Postgresql = Packager::Package::Builder.build do
      title 'Postgresql'
      command 'pamac install postgresql --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
