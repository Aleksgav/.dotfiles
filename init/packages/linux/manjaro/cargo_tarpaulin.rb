# frozen_string_literal: true

module Linux
  module Manjaro
    CargoTarpaulin = Packager::Package::Builder.build do
      title 'Cargo tarpaulin'
      command 'cargo install cargo-tarpaulin'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
