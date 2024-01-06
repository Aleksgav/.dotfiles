# frozen_string_literal: true

module Linux
  module Manjaro
    Timewarrior = Packager::Package::Builder.build do
      title 'Timewarrior'
      command 'pamac install timew --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
