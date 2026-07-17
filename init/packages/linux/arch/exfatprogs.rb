# frozen_string_literal: true

module Linux
  module Arch
    Exfatprogs = Packager::Package::Builder.build do
      title 'exfatprogs (exFAT filesystem tools)'
      command 'pacman -S --needed --noconfirm exfatprogs'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
