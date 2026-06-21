# frozen_string_literal: true

module Linux
  module Arch
    HomeAssistant = Packager::Package::Builder.build do
      title 'Home Assistant'
      command 'yay -S --needed --noconfirm home-assistant'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
