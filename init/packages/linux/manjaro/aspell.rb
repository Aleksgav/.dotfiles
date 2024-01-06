# frozen_string_literal: true

module Linux
  module Manjaro
    Aspell = Packager::Package::Builder.build do
      title 'Aspell'
      command 'pamac install aspell --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
