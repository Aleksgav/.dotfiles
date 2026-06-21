# frozen_string_literal: true

module Linux
  module Arch
    TimerRs = Packager::Package::Builder.build do
      title 'Timer Rs'
      command 'cargo install timer-cli'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
