# frozen_string_literal: true

module Linux
  module Manjaro
     CargoDeny = Packager::Package::Builder.build do
      title 'Cargo deny'
      command '~/.cargo/bin/cargo install cargo-deny'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
