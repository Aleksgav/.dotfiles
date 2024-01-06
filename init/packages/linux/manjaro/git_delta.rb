# frozen_string_literal: true

module Linux
  module Manjaro
    GitDelta = Packager::Package::Builder.build do
      title 'Git delta'
      command 'pamac install git-delta --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
