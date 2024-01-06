# frozen_string_literal: true

module OSX
  module Any
    SheldonInit = Packager::Package::Builder.build do
      title 'Sheldon init'
      command 'sheldon lock'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
