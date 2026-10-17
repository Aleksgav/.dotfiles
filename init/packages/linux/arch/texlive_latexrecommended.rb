# frozen_string_literal: true

module Linux
  module Arch
    TexliveLatexrecommended = Packager::Package::Builder.build do
      title 'TeX Live LaTeX recommended'
      command 'pacman -S --needed --noconfirm texlive-latexrecommended'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
