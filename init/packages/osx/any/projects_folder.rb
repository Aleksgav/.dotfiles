# frozen_string_literal: true

module OSX
  module Any
    ProjectsFolder = Packager::Package::Builder.build do
      title 'Create projects folder'
      command "mkdir -p #{PROJECTS_DIR}"
      os TARGET_OS
      distro TARGET_DISTRO
      sudo_require false
    end
  end
end