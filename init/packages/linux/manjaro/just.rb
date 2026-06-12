# frozen_string_literal: true

module Linux
  module Manjaro
    Just = Packager::Package::Builder.build do
      title 'Just runner'
      command 'pamac install just --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
