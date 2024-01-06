# frozen_string_literal: true

module Linux
  module Manjaro
    Gobang = Packager::Package::Builder.build do
      title 'Gobang'
      command 'cargo install --version 0.1.0-alpha.5 gobang'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
