# frozen_string_literal: true

module OSX
  module Any
    RestartFinder = Packager::Package::Builder.build do
      title 'Restart finder'
      command 'killall Finder'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
