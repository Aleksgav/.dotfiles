# frozen_string_literal: true

module Linux
  module Manjaro
    Rofi = Packager::Package::Builder.build do
      title 'Rofi'
      command 'pamac install rofi --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install { Linker.link 'rofi', "#{CONFIG_DIR}/rofi" }
    end
  end
end
