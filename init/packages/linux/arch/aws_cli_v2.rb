# frozen_string_literal: true

module Linux
  module Arch
    AwsCliV2 = Packager::Package::Builder.build do
      title 'AWS CLI v2'
      command 'pacman -S --needed --noconfirm aws-cli-v2'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
