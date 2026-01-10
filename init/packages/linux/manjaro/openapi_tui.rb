# frozen_string_literal: true

module Linux
  module Manjaro
    OpenAPITUI = Packager::Package::Builder.build do
      title 'OpenAPI TUI'
      command 'pamac install openapi-tui --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
