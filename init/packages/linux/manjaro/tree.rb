# frozen_string_literal: true

module Linux
  module Manjaro
    Tree = Packager::Package::Builder.build do
      title 'Tree'
      command 'pamac install tree --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
