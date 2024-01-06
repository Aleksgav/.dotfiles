# frozen_string_literal: true

module Linux
  module Manjaro
    Zsh = Packager::Package::Builder.build do
      title 'Zsh'
      command 'pamac install zsh --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
