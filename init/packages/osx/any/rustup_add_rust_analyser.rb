# frozen_string_literal: true

module OSX
  module Any
    RustupAddRustAnalyser = Packager::Package::Builder.build do
      title 'Rustup add rust analyser'
      command 'rustup component add rust-analyzer'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
