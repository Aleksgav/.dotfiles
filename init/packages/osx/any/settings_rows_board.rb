# frozen_string_literal: true

module OSX
  module Any
    SettingsRowsBoard = Packager::Package::Builder.build do
      title 'Settings rows on board'
      command 'defaults write com.apple.dock springboard-rows -int 7'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
