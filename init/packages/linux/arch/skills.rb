# frozen_string_literal: true

module Linux
  module Arch
    Skills = Packager::Package::Builder.build do
      title 'Agent skills'
      pre_install do
        Linker.link 'skills', '~/.local/state/skills'
        Linker.mkdir '~/.agents'
      end
      command 'npx skills update -g -y'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
