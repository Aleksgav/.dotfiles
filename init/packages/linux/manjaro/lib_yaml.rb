# frozen_string_literal: true

module Linux
  module Manjaro
    LibYaml = Packager::Package::Builder.build do
      title 'Libyaml'
      command 'pamac install libyaml --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
