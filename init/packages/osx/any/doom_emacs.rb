# frozen_string_literal: true

module OSX
  module Any
    DoomEmacs = Packager::Package::Builder.build do
      cmd =<<-CMD
        git clone --depth 1 https://github.com/doomemacs/doomemacs #{CONFIG_DIR}/emacs
        #{CONFIG_DIR}/emacs/bin/doom install
      CMD

      title 'Doom emacs'
      command cmd
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
