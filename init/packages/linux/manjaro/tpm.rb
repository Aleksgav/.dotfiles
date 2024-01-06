# frozen_string_literal: true

module Linux
  module Manjaro
    Tpm = Packager::Package::Builder.build do
      title 'Tmux plugin manager'
      command 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
