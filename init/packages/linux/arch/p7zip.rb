# frozen_string_literal: true

module Linux
  module Arch
    # Arch dropped `p7zip` from the official repos; `7zip` is the maintained
    # replacement and `provides p7zip` (ships the `7z`/`7za` binaries).
    P7zip = Packager::Package::Builder.build do
      title 'p7zip'
      command 'pacman -S --needed --noconfirm 7zip'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
