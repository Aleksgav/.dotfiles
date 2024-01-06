# frozen_string_literal: true

module OSX
  module Any
     CargoEdit = Packager::Package::Builder.build do
      title 'Cargo edit'
      command 'cargo install cargo-edit'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
