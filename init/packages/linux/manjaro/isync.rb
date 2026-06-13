# frozen_string_literal: true

module Linux
  module Manjaro
    Isync = Packager::Package::Builder.build do
      title 'Isync'
      command 'pamac install isync --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install do
        Linker.link '.mbsyncrc', '~/.mbsyncrc'
        Linker.mkdir '~/Mail'
      end
    end
  end
end
