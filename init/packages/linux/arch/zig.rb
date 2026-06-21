# frozen_string_literal: true

module Linux
  module Arch
    Zig = Packager::Package::Builder.build do
      title 'Zig (mise)'
      command 'mise install zig'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
