# frozen_string_literal: true

module Linux
  module Manjaro
    Just = Packager::Package::Builder.build do
      title 'Just runner'
      command '~/.cargo/bin/cargo install just'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
