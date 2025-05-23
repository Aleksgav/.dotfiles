# frozen_string_literal: true

module OSX
  module Any
    RustupAddNightly = Packager::Package::Builder.build do
      title 'Rustup add nightly'
      command 'rustup install nightly'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
