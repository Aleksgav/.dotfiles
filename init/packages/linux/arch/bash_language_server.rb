# frozen_string_literal: true

module Linux
  module Arch
    BashLanguageServer = Packager::Package::Builder.build do
      title 'Bash Language Server'
      command 'pacman -S --needed --noconfirm bash-language-server'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
