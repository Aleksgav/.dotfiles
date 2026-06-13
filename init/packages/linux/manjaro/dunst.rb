# frozen_string_literal: true

module Linux
  module Manjaro
    Dunst = Packager::Package::Builder.build do
      title 'Dunst'
      command 'pamac install dunst --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install { Linker.link 'dunst', "#{CONFIG_DIR}/dunst" }
    end
  end
end
