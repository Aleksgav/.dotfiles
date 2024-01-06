# frozen_string_literal: true

module Linux
  module Manjaro
     ReloadBash= Packager::Package::Builder.build do
      title 'Bash Reload'
      command 'source ~/.bashrc'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
