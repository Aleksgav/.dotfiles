# frozen_string_literal: true

module Linux
  module Manjaro
    Shellcheck = Packager::Package::Builder.build do
      title 'Shellcheck'
      command 'pamac install shellcheck --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
