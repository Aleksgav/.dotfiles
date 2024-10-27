# frozen_string_literal: true

module Linux
  module Manjaro
    RustupAddNightly = Packager::Package::Builder.build do
      title 'Rustup add nightly'
      command '~/.cargo/bin/rustup install nightly'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
