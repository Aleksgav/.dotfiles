# frozen_string_literal: true

module OSX
  module Any
    Gvm = Packager::Package::Builder.build do
      title 'GVM (Golang Version Manager)'
      command 'bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
