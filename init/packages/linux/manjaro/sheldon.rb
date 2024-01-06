# frozen_string_literal: true

module Linux
  module Manjaro
    Sheldon = Packager::Package::Builder.build do
      title 'Sheldon'
      command 'pamac install sheldon --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
