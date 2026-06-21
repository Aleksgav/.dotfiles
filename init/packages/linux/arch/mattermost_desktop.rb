# frozen_string_literal: true

module Linux
  module Arch
    MattermostDesktop = Packager::Package::Builder.build do
      title 'Mattermost desktop'
      command 'yay -S --needed --noconfirm mattermost-desktop'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
