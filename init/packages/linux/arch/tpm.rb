# frozen_string_literal: true

module Linux
  module Arch
    Tpm = Packager::Package::Builder.build do
      title 'Tmux plugin manager'
      pre_install do
        Linker.backup '~/.tmux/plugins/tpm'
      end
      command 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
