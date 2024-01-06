# frozen_string_literal: true

module Linux
  module Manjaro
    Rabbitmq = Packager::Package::Builder.build do
      title 'Rabbitmq'
      command 'pamac install rabbitmq --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
