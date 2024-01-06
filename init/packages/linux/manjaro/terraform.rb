# frozen_string_literal: true

module Linux
  module Manjaro
    Terraform = Packager::Package::Builder.build do
      title 'Terraform'
      command 'pamac install terraform --no-confirm'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
