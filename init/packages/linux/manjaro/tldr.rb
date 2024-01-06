# frozen_string_literal: true

module Linux
  module Manjaro
    Tldr = Packager::Package::Builder.build do
      title 'Tldr'
      command 'pamac install tldr --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
