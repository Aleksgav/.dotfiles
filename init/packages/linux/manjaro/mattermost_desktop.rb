# frozen_string_literal: true

module Linux
  module Manjaro
    MattermostDesktop = Packager::Package::Builder.build do
      title 'Mattermost desktop'
      command 'snap install mattermost-desktop'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
