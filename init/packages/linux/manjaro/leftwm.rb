# frozen_string_literal: true

module Linux
  module Manjaro
    Leftwm = Packager::Package::Builder.build do
      title 'Leftwm window manager'
      command 'cargo install leftwm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
