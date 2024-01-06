# frozen_string_literal: true

module Linux
  module Manjaro
    Redis = Packager::Package::Builder.build do
      title 'Redis'
      command 'pamac install redis --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
