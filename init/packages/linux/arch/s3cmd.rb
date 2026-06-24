# frozen_string_literal: true

module Linux
  module Arch
    S3cmd = Packager::Package::Builder.build do
      title 'S3cmd'
      command 'pacman -S --needed --noconfirm s3cmd'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
