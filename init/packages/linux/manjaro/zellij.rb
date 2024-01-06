# frozen_string_literal: true

module Linux
  module Manjaro
    Zellij = Packager::Package::Builder.build do
      title 'Zellij'
      command 'pamac install zellij --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
