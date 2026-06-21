# frozen_string_literal: true

module Linux
  module Arch
    Yarn = Packager::Package::Builder.build do
      title 'Yarn'
      command 'npm install --global yarn'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
