# frozen_string_literal: true

module Linux
  module Manjaro
    GoogleChrome= Packager::Package::Builder.build do
      title 'Google chrome'
      command 'pamac build google-chrome --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
