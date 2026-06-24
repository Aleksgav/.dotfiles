# frozen_string_literal: true

module Linux
  module Arch
    BashCompletion = Packager::Package::Builder.build do
      title 'bash-completion'
      command 'pacman -S --needed --noconfirm bash-completion'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
