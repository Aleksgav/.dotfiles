# frozen_string_literal: true

module Linux
  module Arch
    OpenApiTui = Packager::Package::Builder.build do
      title 'OpenAPI TUI'
      command 'pacman -S --needed --noconfirm openapi-tui'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
