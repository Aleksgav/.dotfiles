# frozen_string_literal: true

module Linux
  module Manjaro
    Ghidra = Packager::Package::Builder.build do
      title 'Ghidra'
      command 'pamac install ghidra --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
