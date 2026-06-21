# frozen_string_literal: true

module Linux
  module Arch
    Stack = Packager::Package::Builder.build do
      title 'Stack (mise)'
      command 'mise install stack'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
