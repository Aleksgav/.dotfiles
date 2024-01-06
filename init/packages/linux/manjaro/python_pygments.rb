# frozen_string_literal: true

module Linux
  module Manjaro
    PythonPygments = Packager::Package::Builder.build do
      title 'Python pygments'
      command 'pamac install python-pygments --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
