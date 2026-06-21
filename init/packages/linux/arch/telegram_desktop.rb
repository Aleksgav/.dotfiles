# frozen_string_literal: true

module Linux
  module Arch
    TelegramDesktop = Packager::Package::Builder.build do
      title 'Telegram desktop'
      command 'pacman -S --needed --noconfirm telegram-desktop'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
