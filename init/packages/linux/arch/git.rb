# frozen_string_literal: true

module Linux
  module Arch
    Git = Packager::Package::Builder.build do
      title 'GIT'
      command 'pacman -S --needed --noconfirm git'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install do
        Linker.link '.gitignore-system', '~/.gitignore-system'
        Linker.link '.gitconfig', '~/.gitconfig'
      end
    end
  end
end
