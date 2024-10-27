# frozen_string_literal: true

module Linux
  module Manjaro
    ZshDefault = Packager::Package::Builder.build do
      title 'Set ZSH as default'
      command 'chsh -s /usr/bin/zsh'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
