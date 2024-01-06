# frozen_string_literal: true

module Linux
  module Manjaro
    TreeSitter = Packager::Package::Builder.build do
      title 'Tree sitter'
      command 'pamac install tree-sitter --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
