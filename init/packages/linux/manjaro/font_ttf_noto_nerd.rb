# frozen_string_literal: true

module Linux
  module Manjaro
    FontTtfNotoNerd = Packager::Package::Builder.build do
      title 'Font TTF noto nerd'
      command 'pamac install ttf-noto-nerd --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
