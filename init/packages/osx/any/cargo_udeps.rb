# frozen_string_literal: true

module OSX
  module Any
    CargoUdeps = Packager::Package::Builder.build do
      title 'Cargo udeps'
      command 'cargo install cargo-udeps --locked'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
