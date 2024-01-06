# frozen_string_literal: true

module Linux
  module Manjaro
    Notion = Packager::Package::Builder.build do
      title 'Notion'
      command 'pamac install notion --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
