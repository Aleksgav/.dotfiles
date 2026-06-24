# frozen_string_literal: true

module Linux
  module Arch
    Gitbutler = Packager::Package::Builder.build do
      title 'GitButler'
      command 'yay -S --needed --noconfirm gitbutler-bin'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
