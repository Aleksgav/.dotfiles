# frozen_string_literal: true

module Linux
  module Manjaro
    FontOtfFiramonoNerd = Packager::Package::Builder.build do
      title 'Font OTF fira mono nerd'
      command 'pamac install otf-firamono-nerd --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
