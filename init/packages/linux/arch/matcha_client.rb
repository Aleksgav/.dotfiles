# frozen_string_literal: true

module Linux
  module Arch
    MatchaClient = Packager::Package::Builder.build do
      title 'Matcha'
      command 'yay -S --needed --noconfirm matcha-client-bin'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
