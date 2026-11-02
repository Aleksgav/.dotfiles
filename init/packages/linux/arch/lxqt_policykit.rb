# frozen_string_literal: true

module Linux
  module Arch
    LxqtPolicykit = Packager::Package::Builder.build do
      title 'lxqt-policykit (polkit authentication agent)'
      command 'pacman -S --needed --noconfirm lxqt-policykit'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
