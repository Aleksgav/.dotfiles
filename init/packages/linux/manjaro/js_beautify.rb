# frozen_string_literal: true

module Linux
  module Manjaro
    JsBeautify = Packager::Package::Builder.build do
      title 'Js beautify'
      command 'npm -g install js-beautify --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
