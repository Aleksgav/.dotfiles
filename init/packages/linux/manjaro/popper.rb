# frozen_string_literal: true

module Linux
  module Manjaro
    Popper = Packager::Package::Builder.build do
      title 'Popper'
      command 'pamac install popper --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
