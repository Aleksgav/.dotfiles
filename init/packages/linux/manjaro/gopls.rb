# frozen_string_literal: true

module Linux
  module Manjaro
    Gopls = Packager::Package::Builder.build do
      title 'Gopls'
      command 'pamac install gopls --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
