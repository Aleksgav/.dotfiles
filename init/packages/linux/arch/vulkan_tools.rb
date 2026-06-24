# frozen_string_literal: true

module Linux
  module Arch
    VulkanTools = Packager::Package::Builder.build do
      title 'Vulkan tools'
      command 'pacman -S --needed --noconfirm vulkan-tools'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
