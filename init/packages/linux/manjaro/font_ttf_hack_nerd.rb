# frozen_string_literal: true

module Linux
  module Manjaro
    FontTtfHackNerd = Packager::Package::Builder.build do
      title 'Font TTF Hack nerd'
      command 'pamac install ttf-hack-nerd --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
