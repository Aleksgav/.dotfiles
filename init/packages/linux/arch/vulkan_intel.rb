# frozen_string_literal: true

module Linux
  module Arch
    VulkanIntel = Packager::Package::Builder.build do
      title 'Vulkan Intel'
      command 'pacman -S --needed --noconfirm vulkan-intel'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
