# frozen_string_literal: true

module Linux
  module Arch
    Acpi = Packager::Package::Builder.build do
      title 'acpi'
      command 'pacman -S --needed --noconfirm acpi'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
