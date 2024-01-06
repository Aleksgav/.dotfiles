# frozen_string_literal: true

module Linux
  module Manjaro
    Task = Packager::Package::Builder.build do
      title 'Task'
      command 'pamac install task --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
