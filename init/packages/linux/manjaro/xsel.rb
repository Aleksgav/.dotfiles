# frozen_string_literal: true

module Linux
  module Manjaro
    Xsel = Packager::Package::Builder.build do
      title 'Xsel'
      command 'pamac install xsel --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
