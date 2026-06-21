# frozen_string_literal: true

module Linux
  module Arch
    GitDelta = Packager::Package::Builder.build do
      title 'Git delta'
      command 'pacman -S --needed --noconfirm git-delta'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install { Linker.link '.gitconfig_delta', '~/.gitconfig_delta' }
    end
  end
end
