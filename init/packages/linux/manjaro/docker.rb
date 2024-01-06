# frozen_string_literal: true

module Linux
  module Manjaro
    Docker = Packager::Package::Builder.build do
      title 'Docker'
      command 'pamac install docker --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
