# frozen_string_literal: true

module Linux
  module Manjaro
    GitUi = Packager::Package::Builder.build do
      title 'Git ui'
      command 'pamac install gitui --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
