# frozen_string_literal: true

module Linux
  module Manjaro
    Git = Packager::Package::Builder.build do
      title 'GIT'
      command 'pamac install git --no-confirm'
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
