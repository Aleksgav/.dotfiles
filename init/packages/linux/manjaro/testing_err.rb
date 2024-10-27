# frozen_string_literal: true

module Linux
  module Manjaro
    TestingErr = Packager::Package::Builder.build do
      title 'Testing err'
      command 'xxxxxx'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
