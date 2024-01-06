# frozen_string_literal: true

module Linux
  module Manjaro
    Postman = Packager::Package::Builder.build do
      title 'Postman'
      command 'snap install postman'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
