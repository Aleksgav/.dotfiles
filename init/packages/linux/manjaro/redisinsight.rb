# frozen_string_literal: true

module Linux
  module Manjaro
    Redisinsight = Packager::Package::Builder.build do
      title 'Redisinsight'
      command 'snap install redisinsight'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
