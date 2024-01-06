# frozen_string_literal: true

module Linux
  module Manjaro
    Jq = Packager::Package::Builder.build do
      title 'Jq'
      command 'pamac install jq --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
