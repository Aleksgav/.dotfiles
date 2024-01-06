# frozen_string_literal: true

module Linux
  module Manjaro
    K9s = Packager::Package::Builder.build do
      title 'K9s'
      command 'pamac install k9s --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
