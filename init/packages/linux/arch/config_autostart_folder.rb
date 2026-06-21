# frozen_string_literal: true

module Linux
  module Arch
    ConfigAutostartFolder = Packager::Package::Builder.build do
      title 'Create .config/autostart folder'
      command "mkdir -p #{CONFIG_DIR}/autostart"
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
