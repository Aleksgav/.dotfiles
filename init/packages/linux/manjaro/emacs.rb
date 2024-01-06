# frozen_string_literal: true

module Linux
  module Manjaro
    Emacs = Packager::Package::Builder.build do
      title 'Emacs'
      command 'pamac install emacs --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
