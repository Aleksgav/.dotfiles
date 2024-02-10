# frozen_string_literal: true

module Linux
  module Manjaro
    Bandwhich = Packager::Package::Builder.build do
      title 'Bandwhich'
      command 'pamac install bandwhich --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
