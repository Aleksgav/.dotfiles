# frozen_string_literal: true

module Linux
  module Arch
    FontOtfLatinmodernMath = Packager::Package::Builder.build do
      title 'Font OTF latin modern math'
      command 'pacman -S --needed --noconfirm otf-latinmodern-math'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
