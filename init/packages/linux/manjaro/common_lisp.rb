# frozen_string_literal: true

module Linux
  module Manjaro
    CommonLisp = Packager::Package::Builder.build do
      title 'CommonLisp'
      command 'pamac install sbcl --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
