# frozen_string_literal: true

module Linux
  module Manjaro
    EditorconfigChecker = Packager::Package::Builder.build do
      title 'Editorconfig checker'
      command 'pamac install editorconfig-checker --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
