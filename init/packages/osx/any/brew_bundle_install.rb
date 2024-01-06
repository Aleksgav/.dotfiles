# frozen_string_literal: true

module OSX
  module Any
    BrewBundleInstall = Packager::Package::Builder.build do
      title 'Brew bundle install'
      command "brew bundle install -v"
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end
