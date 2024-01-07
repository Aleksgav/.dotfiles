# frozen_string_literal: true

module Linux
  module Manjaro
    FontNotoEmoji = Packager::Package::Builder.build do
      title 'Font noto emoji'
      command 'pamac install noto-fonts-emoji --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
