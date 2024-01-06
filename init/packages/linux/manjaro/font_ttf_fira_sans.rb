# frozen_string_literal: true

module Linux
  module Manjaro
    FontTtfFiraSans = Packager::Package::Builder.build do
      title 'Font TTF fira sans'
      command 'pamac install ttf-fira-sans --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
