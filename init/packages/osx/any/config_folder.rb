# frozen_string_literal: true

module OSX
  module Any
    ConfigFolder = Packager::Package::Builder.build do
      title 'Create .config folder'
      command "mkdir -p #{CONFIG_DIR}"
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
