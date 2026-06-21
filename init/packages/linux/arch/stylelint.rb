# frozen_string_literal: true

module Linux
  module Arch
    Stylelint = Packager::Package::Builder.build do
      title 'Stylelint'
      command 'npm install --global stylelint'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
