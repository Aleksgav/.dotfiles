# frozen_string_literal: true

module Linux
  module Manjaro
    RubySolargraph = Packager::Package::Builder.build do
      title 'Solargraph (Ruby language server)'
      command 'gem install solargraph'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
