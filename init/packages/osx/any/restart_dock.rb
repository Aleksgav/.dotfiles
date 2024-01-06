# frozen_string_literal: true

module OSX
  module Any
    RestartDock = Packager::Package::Builder.build do
      title 'Restart dock'
      command 'killall Dock'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
