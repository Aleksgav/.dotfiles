# frozen_string_literal: true

module Linux
  module Arch
    Mangowm = Packager::Package::Builder.build do
      title 'MangoWM'
      command 'pacman -S --needed --noconfirm mangowm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install { Linker.link 'mango', "#{CONFIG_DIR}/mango" }
    end
  end
end
