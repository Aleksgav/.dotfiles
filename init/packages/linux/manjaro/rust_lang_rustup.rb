# frozen_string_literal: true

module Linux
  module Manjaro
    RustLangRustup = Packager::Package::Builder.build do
      title 'Rust installation (rustup)'
      command "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y"
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
