# frozen_string_literal: true

module Linux
  module Manjaro
    TimerRs = Packager::Package::Builder.build do
      title 'Timer Rs'
      command '~/.cargo/bin/cargo install timer-cli'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
