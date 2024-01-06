# frozen_string_literal: true

module Linux
  module Manjaro
    Gotop = Packager::Package::Builder.build do
      title 'Gotop'
      command 'span install gotop --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
