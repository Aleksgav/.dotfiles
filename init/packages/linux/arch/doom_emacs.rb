# frozen_string_literal: true

module Linux
  module Arch
    DoomEmacs = Packager::Package::Builder.build do
      cmd = <<-CMD
              if [ -d ~/.emacs.d ]; then
                ~/.emacs.d/bin/doom sync
              else
                git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
                ~/.emacs.d/bin/doom install
              fi
      CMD

      title 'DOOM Emacs'
      command cmd
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
      post_install { Linker.link '.doom.d', "#{CONFIG_DIR}/doom" }
    end
  end
end
