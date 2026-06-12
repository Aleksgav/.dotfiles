# frozen_string_literal: true

module Linux
  module Manjaro
    JustLsp = Packager::Package::Builder.build do
      title 'Just lsp'
      command 'pamac install just-lsp'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
