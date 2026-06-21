# frozen_string_literal: true

module Linux
  module Arch
    Notion = Packager::Package::Builder.build do
      title 'Notion'
      command 'yay -S --needed --noconfirm notion-app-electron'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
