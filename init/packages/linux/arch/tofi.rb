# frozen_string_literal: true

module Linux
  module Arch
    Tofi = Packager::Package::Builder.build do
      title 'Tofi'
      command 'yay -S --needed --noconfirm tofi'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
      post_install { Linker.link 'tofi', "#{CONFIG_DIR}/tofi" }
    end
  end
end
