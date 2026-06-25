# frozen_string_literal: true

module Linux
  module Arch
    WlrRandr = Packager::Package::Builder.build do
      title 'wlr-randr'
      command 'pacman -S --needed --noconfirm wlr-randr'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
