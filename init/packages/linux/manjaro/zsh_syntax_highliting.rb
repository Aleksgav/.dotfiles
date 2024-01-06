# frozen_string_literal: true

module Linux
  module Manjaro
    ZshSyntaxHighliting = Packager::Package::Builder.build do
      title 'Zsh syntax highliting'
      command 'pamac install zsh-syntax-highlighting --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
