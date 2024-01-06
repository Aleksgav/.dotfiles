# frozen_string_literal: true

module OSX
  module Any
    SettingsDockAutohide = Packager::Package::Builder.build do
      title 'Settings dock autohide'
      command 'defaults write com.apple.Dock autohide 1'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
