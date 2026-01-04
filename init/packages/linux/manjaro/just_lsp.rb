# frozen_string_literal: true

module Linux
  module Manjaro
    JustLsp = Packager::Package::Builder.build do
      title 'Just lsp'
      command '~/.cargo/bin/cargo install just-lsp'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
