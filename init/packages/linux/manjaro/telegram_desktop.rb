# frozen_string_literal: true

module Linux
  module Manjaro
    TelegramDesktop = Packager::Package::Builder.build do
      title 'Telegram desktop'
      command 'pamac install telegram-desktop --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
