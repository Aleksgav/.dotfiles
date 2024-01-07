# frozen_string_literal: true

module Linux
  module Manjaro
    YamlLanguageServer = Packager::Package::Builder.build do
      title 'Yaml language server'
      command 'pamac install yaml-language-server --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
