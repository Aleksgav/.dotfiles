# frozen_string_literal: true

module Linux
  module Arch
    # No package to install: fstrim.{service,timer} ship with util-linux (base system).
    # This is a service-enable-only step (periodic SSD TRIM, weekly).
    Fstrim = Packager::Package::Builder.build do
      title 'fstrim.timer'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
      post_install 'systemctl enable fstrim.timer', sudo: true
    end
  end
end
