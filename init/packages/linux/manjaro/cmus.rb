# frozen_string_literal: true

module Linux
  module Manjaro
    Cmus = Packager::Package::Builder.build do
      title 'Cmus'
      command 'pamac install cmus --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
