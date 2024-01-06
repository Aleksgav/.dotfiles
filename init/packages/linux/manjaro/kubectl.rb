# frozen_string_literal: true

module Linux
  module Manjaro
    Kubectl = Packager::Package::Builder.build do
      title 'Kubectl'
      command 'pamac install kubectl --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
