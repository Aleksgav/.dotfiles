# frozen_string_literal: true

module Linux
  module Manjaro
    DoomEmacs = Packager::Package::Builder.build do
      cmd =<<-CMD
              git clone --depth 1 https://github.com/doomemacs/doomemacs #{CONFIG_DIR}/emacs
              #{CONFIG_DIR}/emacs/bin/doom install --env --fonts --force
      CMD

      title 'DOOM Emacs'
      command cmd
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
