# frozen_string_literal: true

module OSX
  module Any
     CargoAudit = Packager::Package::Builder.build do
      title 'Cargo audit'
      command 'cargo install cargo-audit'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
