# frozen_string_literal: true

module Linux
  module Manjaro
    PreCommit = Packager::Package::Builder.build do
      title 'pre-commit'
      command 'pamac install pre-commit --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
