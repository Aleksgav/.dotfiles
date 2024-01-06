# frozen_string_literal: true

module OSX
  module Any
    DoomEmacsIcon = Packager::Package::Builder.build do
      title 'Doom emacs icon'
      command 'ln -s /usr/local/opt/emacs-mac/Emacs.app /Applications'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
