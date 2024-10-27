# frozen_string_literal: true

module Linux
  module Manjaro
     CargoAudit = Packager::Package::Builder.build do
      title 'Cargo audit'
      command '~/.cargo/bin/cargo install cargo-audit'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
