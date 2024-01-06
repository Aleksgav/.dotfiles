# frozen_string_literal: true

module Linux
  module Manjaro
    Unrar = Packager::Package::Builder.build do
      title 'Unrar'
      command 'pamac install unrar --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
