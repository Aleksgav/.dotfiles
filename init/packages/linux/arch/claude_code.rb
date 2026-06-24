# frozen_string_literal: true

module Linux
  module Arch
    ClaudeCode = Packager::Package::Builder.build do
      title 'Claude Code'
      # Anthropic's native installer
      command 'curl -fsSL https://claude.ai/install.sh | bash'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
