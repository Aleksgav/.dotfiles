# frozen_string_literal: true

module OSX
  module Any
    SettingsDisableFinderAnimations = Packager::Package::Builder.build do
      title 'Disable finder animations'
      command 'defaults write com.apple.finder DisableAllAnimations -bool true'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
