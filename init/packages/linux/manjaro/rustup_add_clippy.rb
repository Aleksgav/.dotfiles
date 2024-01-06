# frozen_string_literal: true

module Linux
  module Manjaro
     RustupAddClippy = Packager::Package::Builder.build do
      title 'Rustup add clippy'
      command 'rustup component add clippy'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
