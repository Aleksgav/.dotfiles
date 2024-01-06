# frozen_string_literal: true

module Linux
  module Manjaro
    Python = Packager::Package::Builder.build do
      title 'Python'
      command 'pamac install python --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
