# frozen_string_literal: true

module Linux
  module Arch
    Lib32VulkanIntel = Packager::Package::Builder.build do
      title 'Vulkan Intel (32-bit)'
      command 'pacman -S --needed --noconfirm lib32-vulkan-intel'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
