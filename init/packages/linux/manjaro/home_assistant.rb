# frozen_string_literal: true

module Linux
  module Manjaro
    HomeAssistant = Packager::Package::Builder.build do
      title 'Home Assistant'
      command 'pamac install home-assistant --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
