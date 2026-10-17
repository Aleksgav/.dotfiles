# frozen_string_literal: true

module Linux
  module Arch
    PythonPylatexenc = Packager::Package::Builder.build do
      title 'Python pylatexenc'
      command 'pacman -S --needed --noconfirm python-pylatexenc'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
