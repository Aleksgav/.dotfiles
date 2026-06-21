# frozen_string_literal: true

module Linux
  module Arch
    TreeSitter = Packager::Package::Builder.build do
      title 'Tree sitter'
      command 'pacman -S --needed --noconfirm tree-sitter'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
