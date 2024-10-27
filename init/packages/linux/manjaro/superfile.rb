# frozen_string_literal: true

module Linux
  module Manjaro
    Superfile = Packager::Package::Builder.build do
      title 'Superfile'
      command 'bash -c "$(curl -sLo- https://superfile.netlify.app/install.sh)"'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
