# frozen_string_literal: true

module Linux
  module Manjaro
    Cmus = Packager::Package::Builder.build do
      title 'Gdb'
      command 'pamac install gdb --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
