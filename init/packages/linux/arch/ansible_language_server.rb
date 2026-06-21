# frozen_string_literal: true

module Linux
  module Arch
    AnsibleLanguageServer = Packager::Package::Builder.build do
      title 'Ansible Language Server'
      command 'npm -g install @ansible/ansible-language-server'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
