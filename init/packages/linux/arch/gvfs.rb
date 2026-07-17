# frozen_string_literal: true

# Provides the GVolumeMonitor (over udisks2) that gives Thunar its
# "Removable Devices" sidebar and mount/unmount/eject actions.

module Linux
  module Arch
    Gvfs = Packager::Package::Builder.build do
      title 'gvfs (Thunar volume/mount backend)'
      command 'pacman -S --needed --noconfirm gvfs'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
