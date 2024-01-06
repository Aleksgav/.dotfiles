# frozen_string_literal: true

module Linux
  module Manjaro
    Opera = Packager::Package::Builder.build do
      title 'Opera'
      command 'pamac install opera --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
