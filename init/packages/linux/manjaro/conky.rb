# frozen_string_literal: true

module Linux
  module Manjaro
    Conky = Packager::Package::Builder.build do
      title 'Conky'
      command 'pamac install conky --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install do
        Linker.link 'autostart/conky.desktop', "#{CONFIG_DIR}/autostart/conky.desktop"
        Linker.link 'conky', "#{CONFIG_DIR}/conky"
      end
    end
  end
end
