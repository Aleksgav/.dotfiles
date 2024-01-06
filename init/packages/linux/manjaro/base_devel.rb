# frozen_string_literal: true

module Linux
  module Manjaro
    BaseDevel = Packager::Package::Builder.build do
      title 'Base Devel Tools'
      command 'pamac install base-devel --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end

#       group.command('Autoconf', 'pamac install autoconf --no-confirm')
#       group.command('Automake', 'pamac install automake --no-confirm')
#       group.command('make', 'pamac install make --no-confirm')
#       group.command('cmake', 'pamac install cmake --no-confirm')
#       group.command('coreutils', 'pamac install coreutils --no-confirm')
#       group.command('gcc', 'pamac install gcc --no-confirm')
#       group.command('gdb', 'pamac install gdb --no-confirm')
#       group.command('gnupg', 'pamac install gnupg --no-confirm')
