# frozen_string_literal: true

module Linux
  module Arch
    Mangowm = Packager::Package::Builder.build do
      title 'MangoWM'
      command 'yay -S --needed --noconfirm mangowm-git'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
      post_install { Linker.link 'mango', "#{CONFIG_DIR}/mango" }
    end
  end
end
