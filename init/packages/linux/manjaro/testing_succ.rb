# frozen_string_literal: true

module Linux
  module Manjaro
    TestingSucc = Packager::Package::Builder.build do
      title 'Testing success'
      command 'ls -la && sleep 1 && ls -la'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
