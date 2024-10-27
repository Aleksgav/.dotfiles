# frozen_string_literal: true

module Linux
  module Manjaro
    CargoUdeps = Packager::Package::Builder.build do
      title 'Cargo udeps'
      command '~/.cargo/bin/cargo install cargo-udeps --locked'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
