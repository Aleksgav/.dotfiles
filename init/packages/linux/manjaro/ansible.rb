# frozen_string_literal: true

module Linux
  module Manjaro
    Ansible = Packager::Package::Builder.build do
      title 'Ansible'
      command 'pamac install ansible --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
