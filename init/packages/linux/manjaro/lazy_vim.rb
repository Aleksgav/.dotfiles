# frozen_string_literal: true

module Linux
  module Manjaro
    LazyVim = Packager::Package::Builder.build do
      cmd =<<-CMD
        git clone https://github.com/LazyVim/starter #{CONFIG_DIR}/nvim
      CMD

      title 'Lazy vim'
      command cmd
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
