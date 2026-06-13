# frozen_string_literal: true

module Linux
  module Manjaro
    GoMise = Packager::Package::Builder.build do
      title 'Golang (Mise)'
      command 'mise install go'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
