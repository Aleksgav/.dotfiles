# frozen_string_literal: true

module Linux
  module Manjaro
    Glow = Packager::Package::Builder.build do
      title 'Glow'
      command 'pamac install glow --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
