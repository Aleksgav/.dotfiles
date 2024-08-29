# frozen_string_literal: true

module Linux
  module Manjaro
    Lazygit = Packager::Package::Builder.build do
      title 'Lazygit'
      command 'pamac install lazygit --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
