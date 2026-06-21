# frozen_string_literal: true

module Linux
  module Arch
    YamlLanguageServer = Packager::Package::Builder.build do
      title 'Yaml language server'
      command 'pacman -S --needed --noconfirm yaml-language-server'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
