# frozen_string_literal: true

module Linux
  module Manjaro
    Nodejs = Packager::Package::Builder.build do
      title 'Nodejs'
      command 'mise install node'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
