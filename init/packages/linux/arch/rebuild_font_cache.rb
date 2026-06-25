# frozen_string_literal: true

module Linux
  module Arch
    # Rebuild the fontconfig cache after all fonts are installed, so freshly installed families
    RebuildFontCache = Packager::Package::Builder.build do
      title 'Rebuild font cache'
      command 'fc-cache -fv'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
