# frozen_string_literal: true

module Linux
  module Manjaro
    P7zip = Packager::Package::Builder.build do
      title 'p7zip'
      command 'pamac install p7zip --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
