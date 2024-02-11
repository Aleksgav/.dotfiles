# frozen_string_literal: true

module Linux
  module Manjaro
    Flameshot = Packager::Package::Builder.build do
      title 'Flameshot'
      command 'pamac install flameshot --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
