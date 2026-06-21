# frozen_string_literal: true

module Linux
  module Arch
    Nodejs = Packager::Package::Builder.build do
      title 'Nodejs (mise)'
      command 'mise install node'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
