# frozen_string_literal: true

module Linux
  module Arch
    NetbirdUi = Packager::Package::Builder.build do
      title 'NetBird UI'
      command 'yay -S --needed --noconfirm netbird-ui'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
