# frozen_string_literal: true

module Linux
  module Manjaro
    OpenJdk = Packager::Package::Builder.build do
      title 'Open JDK'
      command 'pamac install jdk-openjdk --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
