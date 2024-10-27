# frozen_string_literal: true

module Linux
  module Manjaro
    CargoWatch = Packager::Package::Builder.build do
      title 'Cargo watch'
      command '~/.cargo/bin/cargo install cargo-watch'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
