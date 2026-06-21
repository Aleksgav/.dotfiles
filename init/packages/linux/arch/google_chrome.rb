# frozen_string_literal: true

module Linux
  module Arch
    GoogleChrome = Packager::Package::Builder.build do
      title 'Google chrome'
      command 'yay -S --needed --noconfirm google-chrome'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
