# frozen_string_literal: true

module Linux
  module Manjaro
    FontTtfFiraCode = Packager::Package::Builder.build do
      title 'Font TTF fira code'
      command 'pamac install ttf-fira-code --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
