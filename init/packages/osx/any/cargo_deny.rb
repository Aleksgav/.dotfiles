# frozen_string_literal: true

module OSX
  module Any
     CargoDeny = Packager::Package::Builder.build do
      title 'Cargo deny'
      command 'cargo install cargo-deny'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
