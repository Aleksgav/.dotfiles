# frozen_string_literal: true

module OSX
  module Any
    CargoWatch = Packager::Package::Builder.build do
      title 'Cargo watch'
      command 'cargo install cargo-watch'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
