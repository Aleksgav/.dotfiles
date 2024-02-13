# frozen_string_literal: true

module Linux
  module Manjaro
    BashLanguageServer = Packager::Package::Builder.build do
      title 'Bash Language Server'
      command 'pamac install bash-language-server --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
