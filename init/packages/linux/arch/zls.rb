# frozen_string_literal: true

module Linux
  module Arch
    Zls = Packager::Package::Builder.build do
      title 'Zls (Zig Language Server, mise)'
      command 'mise install zls'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
