# frozen_string_literal: true

module OSX
  module Any
    SettingsColumnsBoard = Packager::Package::Builder.build do
      title 'Settings columns on board'
      command 'defaults write com.apple.dock springboard-columns -int 10'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
