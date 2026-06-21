# frozen_string_literal: true

module Linux
  module Arch
    Postman = Packager::Package::Builder.build do
      title 'Postman'
      command 'yay -S --needed --noconfirm postman-bin'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
