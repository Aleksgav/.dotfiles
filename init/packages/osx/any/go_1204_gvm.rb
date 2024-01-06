# frozen_string_literal: true

module OSX
  module Any
    Go1204Gvm = Packager::Package::Builder.build do
      title 'Golang 1.20.4 (GVM)'
      command 'gvm install go1.20.4'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
