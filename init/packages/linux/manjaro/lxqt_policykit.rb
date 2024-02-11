# frozen_string_literal: true

module Linux
  module Manjaro
    LxqtPolicykit = Packager::Package::Builder.build do
      title 'lxqt-policykit'
      command 'pamac install lxqt-policykit --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
