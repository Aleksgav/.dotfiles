# frozen_string_literal: true

module Linux
  module Manjaro
    Golang = Packager::Package::Builder.build do
      title 'Golang (mise)'
      command 'mise install go'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
