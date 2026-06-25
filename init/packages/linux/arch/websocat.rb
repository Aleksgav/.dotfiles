# frozen_string_literal: true

module Linux
  module Arch
    Websocat = Packager::Package::Builder.build do
      title 'websocat'
      command 'pacman -S --needed --noconfirm websocat'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
