# frozen_string_literal: true

module Linux
  module Arch
    LibreOffice = Packager::Package::Builder.build do
      title 'LibreOffice'
      # NOTE: Must be force it with SAL_USE_VCLPLUGIN=gtk3 in the session env.
      command 'pacman -S --needed --noconfirm libreoffice-fresh gtk3'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
