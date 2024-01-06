# frozen_string_literal: true

module Linux
  module Manjaro
    ProjectsFolder = Packager::Package::Builder.build do
      title 'Create projects folder'
      command "mkdir -p #{PROJECTS_DIR}"
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require true
    end
  end
end
