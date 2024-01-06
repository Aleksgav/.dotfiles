# frozen_string_literal: true

module Linux
  module Manjaro
    Nodejs = Packager::Package::Builder.build do
      title 'Nodejs'
      command 'pamac install nodejs --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
