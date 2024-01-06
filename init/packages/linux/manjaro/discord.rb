# frozen_string_literal: true

module Linux
  module Manjaro
    Discord = Packager::Package::Builder.build do
      title 'Discord'
      command 'pamac install discord --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
