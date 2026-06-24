# frozen_string_literal: true

module Linux
  module Arch
    GithubCli = Packager::Package::Builder.build do
      title 'Github CLI'
      command 'pacman -S --needed --noconfirm github-cli'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
