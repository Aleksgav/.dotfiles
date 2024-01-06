# frozen_string_literal: true

module Linux
  module Manjaro
    Httpie = Packager::Package::Builder.build do
      title 'Httpie'
      command 'pamac install httpie --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
