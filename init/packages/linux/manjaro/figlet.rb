# frozen_string_literal: true

module Linux
  module Manjaro
    Figlet = Packager::Package::Builder.build do
      title 'Figlet'
      command 'pamac install figlet --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
