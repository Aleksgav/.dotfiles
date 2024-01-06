# frozen_string_literal: true

module Linux
  module Manjaro
    Alacritty = Packager::Package::Builder.build do
      title 'Alacritty'
      command 'pamac install alacritty --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
