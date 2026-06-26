# frozen_string_literal: true

module Linux
  module Arch
    Tuigreet = Packager::Package::Builder.build do
      title 'tuigreet (greetd greeter)'
      command 'pacman -S --needed --noconfirm greetd-tuigreet'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
      post_install 'install -d -o greeter -g greeter -m 0755 /var/cache/tuigreet', sudo: true
    end
  end
end
