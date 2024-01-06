# frozen_string_literal: true

module Linux
  module Manjaro
    Tmux = Packager::Package::Builder.build do
      title 'Tmux'
      command 'pamac install tmux --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
