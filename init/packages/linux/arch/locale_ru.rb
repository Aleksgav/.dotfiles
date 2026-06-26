# frozen_string_literal: true

module Linux
  module Arch
    LocaleRu = Packager::Package::Builder.build do
      title 'Russian locale (ru_RU.UTF-8)'
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
      post_install "sed -i '/^#ru_RU\\.UTF-8 UTF-8/s/^#//' /etc/locale.gen", sudo: true
      post_install 'locale-gen', sudo: true
    end
  end
end
