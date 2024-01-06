# frozen_string_literal: true

module OSX
  module Any
     CargoExpand = Packager::Package::Builder.build do
      title 'Cargo expand'
      command 'cargo install cargo-expand'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
