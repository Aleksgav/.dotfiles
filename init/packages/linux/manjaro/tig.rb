# frozen_string_literal: true

module Linux
  module Manjaro
    Tig = Packager::Package::Builder.build do
      title 'Tig'
      command 'pamac install tig --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
