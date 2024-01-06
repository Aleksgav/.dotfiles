# frozen_string_literal: true

module Linux
  module Manjaro
    LibJemalloc = Packager::Package::Builder.build do
      title 'Jemalloc'
      command 'pamac install jemalloc --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
