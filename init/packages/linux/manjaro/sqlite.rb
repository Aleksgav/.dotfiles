# frozen_string_literal: true

module Linux
  module Manjaro
    Sqlite = Packager::Package::Builder.build do
      title 'Sqlite'
      command 'pamac install sqlite --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
