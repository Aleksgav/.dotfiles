# frozen_string_literal: true

module Linux
  module Arch
    Ghidra = Packager::Package::Builder.build do
      title 'Ghidra'
      command 'pacman -S --needed --noconfirm ghidra'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      # r2ghidra: use Ghidra's decompiler inside radare2.
      # Installed via r2pm (radare2's package manager), so radare2 must be installed first.
      post_install 'r2pm -U && r2pm -ci r2ghidra'
    end
  end
end
