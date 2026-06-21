# frozen_string_literal: true

module Linux
  module Arch
    PythonPygments = Packager::Package::Builder.build do
      title 'Python pygments'
      command 'pacman -S --needed --noconfirm python-pygments'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
