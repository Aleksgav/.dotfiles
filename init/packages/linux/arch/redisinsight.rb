# frozen_string_literal: true

module Linux
  module Arch
    Redisinsight = Packager::Package::Builder.build do
      title 'Redisinsight'
      command 'yay -S --needed --noconfirm redisinsight-bin'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
