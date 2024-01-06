# frozen_string_literal: true

module Linux
  module Manjaro
    AnsibleLint = Packager::Package::Builder.build do
      title 'Ansible Lint'
      command 'pamac install ansible-lint --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
