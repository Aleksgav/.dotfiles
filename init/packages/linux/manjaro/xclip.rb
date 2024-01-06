# frozen_string_literal: true

module Linux
  module Manjaro
    Xclip = Packager::Package::Builder.build do
      title 'Xclip'
      command 'pamac install xclip --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
