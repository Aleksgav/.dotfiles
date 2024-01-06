# frozen_string_literal: true

module Linux
  module Manjaro
    DiffSoFancy = Packager::Package::Builder.build do
      title 'Diff so fancy'
      command 'pamac install diff-so-fancy --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
