# frozen_string_literal: true

module Linux
  module Arch
    TreeSitterCli = Packager::Package::Builder.build do
      title 'Tree sitter CLI'
      command 'pacman -S --needed --noconfirm tree-sitter-cli'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
