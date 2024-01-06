# frozen_string_literal: true

module OSX
  module Any
    Tpm = Packager::Package::Builder.build do
      title 'TPM (Tmux Plugin Manager)'
      command 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
