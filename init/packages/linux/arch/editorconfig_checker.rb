# frozen_string_literal: true

module Linux
  module Arch
    EditorconfigChecker = Packager::Package::Builder.build do
      title 'Editorconfig checker'
      command 'pacman -S --needed --noconfirm editorconfig-checker'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
