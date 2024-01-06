# frozen_string_literal: true

module Linux
  module Manjaro
    Ripgrep = Packager::Package::Builder.build do
      title 'Ripgrep'
      command 'pamac install ripgrep --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
